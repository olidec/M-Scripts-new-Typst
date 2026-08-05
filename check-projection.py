#!/usr/bin/env python3
"""
check-projection.py — find points that become ambiguous when a 3D figure
is flattened onto the page.

WHY THIS EXISTS
---------------
The house projection is alpha = 45 deg, k = 1/sqrt(2), chosen so figures
can be copied onto 5 mm squared paper. That choice makes

    (x, y, z)  ->  (y - x/2,  x/2 - z)

because k*cos(45) = k*sin(45) = 1/2 exactly. Every lattice point of a
cube therefore lands on a HALF-INTEGER screen point, and collisions are
not rare accidents -- they are the generic case. On the standard 4-unit
cube, four screen positions already carry two lattice points each.

The failure this catches is subtler than two dots overlapping. A marked
point can land exactly ON another edge, so the reader cannot tell which
edge it belongs to. Concretely: the midpoint of edge BF projects onto
the midpoint of the hidden edge DC. A student asked to draw the plane
section through that point has no way to know which edge was meant.

Run this over every marked point in a cube or space3d figure before
committing the figure.

USAGE
-----
    python3 check-projection.py                    # standard 4-cube
    python3 check-projection.py W:4,2,0 Y:4,4,2    # plus named points
    python3 check-projection.py --a 6 --tol 0.25 P:0,3,1
"""

import argparse
import itertools
import math
import sys

ALPHA_DEG = 45.0
K = math.sqrt(2) / 2


def project(p, alpha_deg=ALPHA_DEG, k=K):
    """World (x, y, z) -> screen (X, Y), screen Y growing downward."""
    x, y, z = p
    a = math.radians(alpha_deg)
    return (y - k * math.cos(a) * x, -(z - k * math.sin(a) * x))


def cube_vertices(a=4.0):
    """German school lettering: bottom ABCD ccw from above, top EFGH."""
    return {
        "A": (a, 0, 0), "B": (a, a, 0), "C": (0, a, 0), "D": (0, 0, 0),
        "E": (a, 0, a), "F": (a, a, a), "G": (0, a, a), "H": (0, 0, a),
    }


CUBE_EDGES = [
    ("A", "B"), ("B", "C"), ("C", "D"), ("D", "A"),
    ("E", "F"), ("F", "G"), ("G", "H"), ("H", "E"),
    ("A", "E"), ("B", "F"), ("C", "G"), ("D", "H"),
]


def _dist_to_segment(p, s0, s1):
    """Distance from screen point p to screen segment s0-s1, plus the
    parameter along the segment where the foot of the perpendicular
    falls (clamped to [0, 1])."""
    px, py = p
    x0, y0 = s0
    x1, y1 = s1
    dx, dy = x1 - x0, y1 - y0
    den = dx * dx + dy * dy
    if den < 1e-12:
        return math.dist(p, s0), 0.0
    t = ((px - x0) * dx + (py - y0) * dy) / den
    t = max(0.0, min(1.0, t))
    foot = (x0 + t * dx, y0 + t * dy)
    return math.dist(p, foot), t


def check(points, segments, tol=0.2, alpha_deg=ALPHA_DEG, k=K):
    """points:   {name: (x, y, z)}
    segments: [(name_a, name_b, (xa,ya,za), (xb,yb,zb)), ...]
    tol:      screen distance, in WORLD UNITS, below which two things
              are treated as visually coincident.
    Returns a list of human-readable problem strings."""
    problems = []
    proj = {n: project(p, alpha_deg, k) for n, p in points.items()}

    # 1. two marked points landing on the same spot
    for (n1, p1), (n2, p2) in itertools.combinations(proj.items(), 2):
        d = math.dist(p1, p2)
        if d < tol:
            problems.append(
                f"POINT/POINT  {n1} and {n2} project {d:.3f} apart "
                f"-- they will read as one dot"
            )

    # 2. a marked point landing on a segment it does not belong to
    for name, wp in points.items():
        for a_name, b_name, wa, wb in segments:
            # skip if the point IS on this segment in space
            if _on_segment_3d(wp, wa, wb):
                continue
            d, t = _dist_to_segment(proj[name], project(wa, alpha_deg, k),
                                    project(wb, alpha_deg, k))
            if d < tol and 0.02 < t < 0.98:
                problems.append(
                    f"POINT/EDGE   {name} projects onto edge {a_name}{b_name} "
                    f"at {d:.3f} (fraction {t:.2f} along it) "
                    f"-- ambiguous which edge it sits on"
                )
    return problems


def _on_segment_3d(p, a, b, eps=1e-9):
    ab = [b[i] - a[i] for i in range(3)]
    ap = [p[i] - a[i] for i in range(3)]
    cross = (
        ab[1] * ap[2] - ab[2] * ap[1],
        ab[2] * ap[0] - ab[0] * ap[2],
        ab[0] * ap[1] - ab[1] * ap[0],
    )
    if sum(c * c for c in cross) > eps:
        return False
    den = sum(v * v for v in ab)
    if den < eps:
        return False
    t = sum(ab[i] * ap[i] for i in range(3)) / den
    return -eps <= t <= 1 + eps


def _parse_point(s):
    name, _, coords = s.partition(":")
    parts = [float(v) for v in coords.split(",")]
    if len(parts) != 3:
        raise ValueError(f"need three coordinates in {s!r}")
    return name, tuple(parts)


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("points", nargs="*", metavar="NAME:x,y,z",
                    help="extra marked points to check")
    ap.add_argument("--a", type=float, default=4.0, help="cube side (default 4)")
    ap.add_argument("--tol", type=float, default=0.2,
                    help="coincidence tolerance in world units (default 0.2)")
    ap.add_argument("--alpha", type=float, default=ALPHA_DEG)
    ap.add_argument("--k", type=float, default=K)
    ap.add_argument("--no-cube", action="store_true",
                    help="check only the supplied points, no cube edges")
    args = ap.parse_args(argv)

    V = cube_vertices(args.a)
    points = {} if args.no_cube else dict(V)
    segments = [] if args.no_cube else [
        (x, y, V[x], V[y]) for x, y in CUBE_EDGES
    ]

    for spec in args.points:
        name, p = _parse_point(spec)
        points[name] = p

    problems = check(points, segments, tol=args.tol,
                     alpha_deg=args.alpha, k=args.k)

    if not problems:
        print(f"OK — no projected coincidences above tol={args.tol}")
        return 0
    print(f"{len(problems)} problem(s) at tol={args.tol}:\n")
    for p in problems:
        print("  " + p)
    print("\nFix by moving the marked point off the midpoint of its edge, "
          "or by choosing a different edge.")
    return 1


if __name__ == "__main__":
    sys.exit(main())

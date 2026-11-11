#!/usr/bin/env python3
"""Быстрый анализ n-грамм трассы 'User <- Operand' (окна 1..N) через numpy.

Формат вывода совпадает с analyze.py: stats/patterns.txt + patterns_nK.csv.
Нужен для больших трасс (десятки миллионов записей).

    python3 scripts/analyze_fast.py build/trace.log -o stats -k 20 -n 5
"""
import argparse
import csv
import os

import numpy as np


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("trace")
    ap.add_argument("-o", "--out", default="stats")
    ap.add_argument("-k", "--top", type=int, default=20)
    ap.add_argument("-n", "--max-window", type=int, default=5)
    a = ap.parse_args()

    vocab, ids = {}, []
    with open(a.trace, "r", encoding="utf-8", errors="replace") as f:
        for ln in f:
            ln = ln.rstrip("\n")
            if not ln:
                continue
            i = vocab.get(ln)
            if i is None:
                i = vocab[ln] = len(vocab)
            ids.append(i)
    names = [None] * len(vocab)
    for s, i in vocab.items():
        names[i] = s
    toks = np.asarray(ids, dtype=np.uint64)
    total = len(toks)
    base = np.uint64(len(vocab))
    assert len(vocab) ** a.max_window < 2**63, "словарь слишком велик для кодирования"

    os.makedirs(a.out, exist_ok=True)
    rep = [
        "# Анализ паттернов трассы use-записей (User <- Operand)",
        f"Файл трассы : {a.trace}",
        f"Всего записей (токенов): {total}",
        f"Уникальных записей (n=1): {len(vocab)}",
        f"Окна: 1..{a.max_window}; топ-{a.top} на окно",
        "",
    ]
    for n in range(1, a.max_window + 1):
        m = total - n + 1
        key = toks[:m].copy()
        for j in range(1, n):
            key = key * base + toks[j : j + m]
        uniq, cnt = np.unique(key, return_counts=True)
        order = np.argsort(-cnt, kind="stable")

        def decode(k):
            out = []
            k = int(k)
            for _ in range(n):
                out.append(names[k % len(vocab)])
                k //= len(vocab)
            return out[::-1]

        rep += [
            "=" * 72,
            f"[окно = {n} инстр.]  различных паттернов: {len(uniq)}  всего окон: {m}",
            "-" * 72,
            f"{'count':>12}  {'доля':>7}  паттерн",
        ]
        for idx in order[: a.top]:
            c = int(cnt[idx])
            rep.append(f"{c:>12}  {100.0*c/m:6.2f}%  " + "  ,  ".join(decode(uniq[idx])))
        rep.append("")
        with open(os.path.join(a.out, f"patterns_n{n}.csv"), "w", newline="") as cf:
            w = csv.writer(cf)
            w.writerow([f"tok{i+1}" for i in range(n)] + ["count", "share_pct"])
            for idx in order:
                c = int(cnt[idx])
                w.writerow(decode(uniq[idx]) + [c, f"{100.0*c/m:.6f}"])

    with open(os.path.join(a.out, "patterns.txt"), "w", encoding="utf-8") as of:
        of.write("\n".join(rep) + "\n")
    print("\n".join(rep))


if __name__ == "__main__":
    main()

# Orbit Documentation

Orbit is a decentralized AMM-based prediction market protocol for trading binary outcomes on real-world events. Markets are initialized through belief-based liquidity commitments, updated through continuous trading, and settled on-chain at expiry.

This documentation is organized for readers who want to understand how Orbit works, why its market structure is different, and what risks and incentives shape participation.

## Start Here

- [Getting Started](./getting-started/README.md): A concise overview of Orbit, its participants, and the market lifecycle.
- [Core Concepts](./concepts/README.md): Why prediction markets matter and where existing market structures fall short.
- [Protocol Design](./protocol/README.md): How Orbit initializes markets, evolves prices, and supports trading.
- [Market Lifecycle](./protocol/market-lifecycle.md): Phase-by-phase walkthrough from creation to settlement.
- [Technical Appendix](./protocol/technical-appendix.md): Implementation-oriented mechanics behind pricing, liquidity, and settlement.
- [Economics](./economics/README.md): Fees, incentives, and the role of liquidity providers, traders, and referrers.
- [Risks](./risks/README.md): Market, liquidity, oracle, smart contract, and legal risks.
- [Team & Roadmap](./team-roadmap/README.md): Execution plan, milestones, and governance progression.

## What Makes Orbit Different

- Belief before liquidity: markets do not begin from arbitrary defaults or heuristic launch prices.
- Probability-native pricing: YES and NO tokens trade as probability expressions rather than generic asset pairs.
- Time-aware liquidity adjustment: liquidity exposure is reduced as markets approach resolution.
- Deterministic settlement: winning tokens redeem on-chain and losing tokens expire worthless.
- Solana-native execution: Orbit's current design uses Meteora DLMM on Solana for high-frequency liquidity updates and low-fee trading.

## Documentation Principles

This site is adapted from the Orbit whitepaper and reorganized for public documentation. It is intended to explain protocol design clearly, not to replace audits, legal review, or implementation repositories.

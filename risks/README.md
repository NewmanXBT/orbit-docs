# Risks

Participation in prediction markets involves meaningful risk. Orbit is designed to improve market structure, not eliminate uncertainty.

## Market Risk

Prediction market prices reflect collective beliefs, not guaranteed outcomes. Prices can be wrong for long periods and may fail to converge cleanly before expiry.

## Liquidity Risk

Available depth changes over time and across probability ranges. Users may face slippage, weak execution, or reduced ability to enter and exit during low-activity periods or near expiry.

## Forecast Risk for Liquidity Providers

Orbit frames LP risk primarily as forecast error. If the probability assumptions committed during initialization are materially wrong, LPs can lose value even when the market remains active.

Dynamic liquidity adjustment may reduce concentration risk, but it does not remove loss scenarios.

LP risk should be interpreted as softened directional exposure, not risk-free market making.

## Initialization Manipulation Risk

A capital-weighted opening price can be gamed by well-capitalized participants who submit distorted initial beliefs and then trade against the induced opening state.

Mitigation candidates include commit-reveal submissions, nonlinear weighting, and bounded/outlier contribution rules. Each mitigation introduces trade-offs in complexity, censorship risk, or capital efficiency.

## Oracle and Resolution Risk

Final settlement depends on external reporting of real-world outcomes. Delays, ambiguities, or failures in oracle design can affect the timing or correctness of resolution.

Orbit's current design direction is an optimistic-oracle-style challenge flow with proposer bonds and dispute windows. This reduces single-publisher trust but does not eliminate oracle-layer failure modes.

## Smart Contract Risk

Orbit depends on on-chain smart contracts. Bugs, exploit paths, faulty integrations, or edge-case interactions can lead to partial or total loss of funds.

## Regulatory and Legal Risk

Prediction markets can face different legal treatment across jurisdictions. Access, product design, and feature scope may need to change as regulation evolves.

## No Investment Advice

Nothing in this documentation should be interpreted as financial, legal, or investment advice.

## Experimental Status

Orbit is still an evolving protocol. Features, parameters, and incentives described in the whitepaper should be treated as current design intent, not immutable guarantees.

# Protocol Design

## Overview

Orbit structures each market as a time-bounded binary event with on-chain settlement. The protocol separates market initialization, trading, liquidity adjustment, and resolution so that prices remain interpretable throughout the market lifecycle.

The current implementation direction is Solana-native and uses Meteora DLMM as the AMM execution substrate.

![How Orbit works](../assets/images/figure-2-how-orbit-works.png)

## Core Components

### 1. Market Creation

Each market defines:

- A binary YES/NO outcome
- A clear expiry time
- Resolution criteria for final settlement

Trading is not enabled at creation time.

### 2. Belief-Based Liquidity Formation

Before trading begins, liquidity providers commit:

- Capital
- A probability expectation for the YES outcome

These commitments are aggregated into a capital-weighted probability surface. The opening price reflects committed expectations rather than arbitrary launch parameters.

### 3. AMM-Driven Trading

After initialization, traders buy and sell YES/NO outcome tokens through the AMM. In Orbit, the AMM is an execution layer and information aggregation mechanism. It does not determine the market's initial beliefs.

### 4. Dynamic Liquidity Adjustment

As expiry approaches and uncertainty declines, Orbit reduces effective liquidity exposure. This aims to prevent late-stage directional risk from concentrating entirely on liquidity providers.

### 5. Resolution and Settlement

At expiry, the market is resolved based on an external oracle mechanism. Smart contracts settle the winning and losing outcome tokens on-chain.

## Oracle and Dispute Flow

Oracle resolution is the largest trust assumption in any prediction market. Orbit's default design target is an Optimistic Oracle pattern (UMA-style escalation game), with explicit challenge windows and bonds.

Planned resolution flow:

1. A proposer submits the outcome and posts a bond.
2. A fixed challenge period opens.
3. If unchallenged, the proposed outcome finalizes.
4. If challenged, the dispute escalates to the oracle resolution process.
5. Incorrect submissions are penalized through bond loss or slashing.
6. If oracle resolution is delayed or unavailable, the market enters a fail-safe state with paused settlement until a governance-defined fallback path is executed.

Alternative oracle paths such as Chainlink Functions remain possible for event types with highly structured API-verifiable outcomes.

## Order Types

Orbit supports:

- Market orders for immediate execution at current probabilities
- Limit-order-like behavior through conditional LP positions within the AMM

![Market orders vs limit orders](../assets/images/figure-3-market-vs-limit-orders.png)

All execution remains pool-based. Users are not matched directly against each other.

## AI Discovery Layer

Orbit includes an optional AI-assisted discovery and drafting layer. Its role is to surface emerging topics and help structure candidate markets before launch.

These AI components do not:

- Set prices
- Allocate liquidity
- Resolve outcomes
- Override smart contract settlement

They are support tooling, not protocol authority.

## Participant Roles

### Liquidity Providers

Liquidity providers contribute capital and a probability view during initialization. Their risk is a softened form of directional exposure: loss magnitude depends on divergence between stated probability and realized outcome. Time-aware decay can reduce terminal concentration, but it cannot eliminate losses under extreme divergence.

### Traders

Traders enter and exit based on changing information. They use market prices as continuously updated probability signals and interact only with the AMM execution layer.

## Adversarial Considerations in Initialization

A capital-weighted opening price can be manipulated by large LP actors who submit distorted beliefs and trade against the induced opening state. Orbit treats this as a first-order design risk.

Planned mitigation options:

- commit-reveal for LP belief submissions before opening price computation
- bounded contribution rules or outlier filters with explicit governance controls
- nonlinear weighting (for example square-root capital weighting) to reduce concentration power

Final mitigation design is pending implementation benchmarking and governance review.

## Design References

- [UMA documentation](https://docs.uma.xyz)
- [Chainlink Functions documentation](https://docs.chain.link/chainlink-functions)

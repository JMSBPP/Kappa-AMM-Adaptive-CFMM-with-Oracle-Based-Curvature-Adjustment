# KAPPA: Adaptive AMM Curvature through Oracle-Driven Market Calibration

<div style="text-align: center;">
  <img src="docs/images/kappa logo.png" alt="Description" width="300"/>
</div>

## Overview

Kappa is a CFMM-type AMM based on CPMM pools (specifically Uniswap V2).

It replicates existing pools and assigns the optimal curvature to the underlying trading function based on market conditions, empirically.

- **Purpose**: Enhance the capital efficiency of Uniswap V2 passive liquidity providers relative to risk inventory minimization and liquidity volume fulfillment.
- **Responsibilities**:
  - Manage liquidity providers' Uniswap V2 pool subscriptions.
  - Actively react to each liquidity provider action.
  - Passively listen to swap actions and process them for liquidity demand estimation and signals.
  - Proactively adjust liquidity providers' inventories among markets based on demand estimation signals.

- **Discussion**: Kappa responds to the state of the Uniswap V2 pool to ensure that passive liquidity providers supply an optimal quantity of liquidity based on current market conditions. Thus, the Kappa optimal pool system can be considered a dynamic optimizer for liquidity providers and a market-making tool for the Uniswap V2 protocol.

See technical documentation: [Technical Documentation](https://drive.google.com/file/d/1myh-z2kM6JcR-JftVUKVxErVNJtpqPBr/view?usp=sharing)  
See software documentation: [Software Documentation](https://github.com/JMSBPP/Kappa-AMM-Adaptive-CFMM-with-Oracle-Based-Curvature-Adjustment/tree/main/docs)

## Quickstart

```bash
git clone https://github.com/JMSBPP/Kappa-AMM-Adaptive-CFMM-with-Oracle-Based-Curvature-Adjustment.git
cd contracts
forge build
```


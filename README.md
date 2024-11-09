
# KAPPA: Adaptive AMM Curvature through Oracle-Driven Market Calibration
<div style="text-align: center;">
  <img src="kappa logo.png" alt="Description" width="300"/>
</div>

## Overview

Kappa is a CFMM-type AMM based on CPMM pools (specifically Uniswap V2 and Sushiswap). It replicates existing pools and assigns the optimal curvature to the underlying trading function, based on market conditions, empirically.

## Problem

CPMM were the first type of CFMM-based AMM implemented in DeFi. They implement a simplistic yet widely accepted trading function that assigns fixed weights to its reserves, making it a homogeneous function of degree one. This means that, by Euler’s theorem, it has constant scale returns.

The curvature of its underlying iso-liquidity curve (analogous to the indifference curve in utility theory) represents the level curve of the trading function at certain reserve levels and has some desired properties:

1. It has an inverse relationship with market liquidity, which is a desirable property because it reduces slippage costs for traders and brings the CFMM exchange rate closer to the actual exchange rate in the external market, thereby reducing the arbitrage problem. This, in turn, lowers adverse selection costs for liquidity providers.[1].

...

[1]: [https://arxiv.org/pdf/2103.08842] Capponi, A., & Jia, R. (2021). The Adoption of Blockchain-Based Decentralized Exchanges.

1. It is bounded below, which in turn bounds above the slippage cost that consumers (traders) incur while trading.[2].


...

[2]: [https://arxiv.org/pdf/2003.10001] Angeris, G., & Chitra, T. (2020, June). Improved Price Oracles: Constant Function Market Makers. Stanford University/Gauntlet Network.

Even though it has some economically desirable properties, it is completely internally (endogenously) adjusted, which can lead to updated lags in response to the external market.

This has some negative consequences, as it exploits the arbitrage problem and increases liquidity provider adverse selection costs, which demotivates them from providing liquidity and, in general, negatively affects the expected payoff of LPs.[1].[3].

...


[3]: [https://anthonyleezhang.github.io/pdfs/lvr.pdf] Milionis, J., Moallemi, C. C., Roughgarden, T., & Zhang, A. L. (2024, May). Automated Market Making and Loss-Versus-Rebalancing. Columbia University & University of Chicago.





## Solution

As a solution analogous to government control over markets, oracles work in a decentralized manner to adjust AMMs to external market conditions without relying on external actors that introduce negative externalities.

Equilibrium economic models for optimal market making in AMM'S (reference) propose that the optimal curvature in any AMM occurs where the preference premium of investors for any of the tokens in the pool is greater than external shocks to the effective price of the AMM, and the trading volume is maximized.


$$
\begin{aligned}
\max(\frac{\text{Trading Volume}}{V_Z^{\text{CFMM}}} \mid \text{Trader preference's premia over } X \vee Y > 
\text{Idisioncratic price shocks} X \  \text{XOR} \ Y) \\

\equiv \\

\boxed{\kappa = \text{optimal} \ \kappa }

\end{aligned}

$$

This proposition has been tested in the following econometric analysis (reference)


Where $(X,Y)$ are the tokens in the pool, $Z$ represents a numeraire used to calculate the value of the pool $V_Z^{\text{CFMM}}$ and $\kappa$ represents the curvature of the pool's trading function.



## Method

1. The user selects a pair of traded tokens already in a CPMM market.
2. An oracle from the most liquid pool is assigned to the pool.
3. The pool conditions are replicated in proportion to the initial 4. 
4. liquidity provided by the user.
5. The curvature is obtained parametrically from the oracle pool.
6. The oracle signals the pool when events occur.
7. The pool automatically adjusts its curvature based on the oracle's input.


## To Do lists:

0. Verificar hipotesis de articulo con datos
   
   
   0.1 Disenar pipeline de datos
   
   
   0.3 especificar modelo econometrico
   
   0.4 Conclusiones

**POSIBLES RESULTADOS**
- ACEPTA HIPOTESIS
   - SE CONTINUA CON PROYECTO.
- RECHAZO HIPOTESIS 
  - SE RE-FORMULA PROYECTO

1. Parametrizar curvatura de funcion de conservacion de CPMM implementable en Solidity
2. Diseñar reactive system (servidores) en reactive contract para los siguientes consultas.[4]


...

[4]: [https://reactive.network/] Reactive Network. (2024, March 1). Reactive Smart Contracts: What They are and Why We Need Them.


   2.1 Dados direccion de par de tokens extraer el mas liquido del contrato factory de Uniswap o Sushiswap
   2.2 Aplicar regla de choque precio $<$ Prima de preferencia
   2.3 Servidor que extrae volumen de comercio
   2.4 Unificador de servidor de volumen de comercion con regla de choque precio $<$ Prima de preferencia
3. Diseñar sistema AMM
   3.1 clases (contratos)
   3.2 Politicas
   3.3 Eventos
   3.4 Actores
   3.5 Roles
   3.6 Seguridad
   3.7 Diagrama de funciones
   3.8 Diagrama de clases (contratos del sistema)(interaccion de contratos)
   3.9 Implementacion contrato
4. Ciclo de desarrollo


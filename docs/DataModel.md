# Econometric Tests


One of the main results of the general equilibrium model for market making is that where transactional trading is incentivezed, this is,the preferences of this traders over the tokens on the pool is greater that the fees they pay. There exists an optimal curvature $\kappa_F^{*}$ that defines the social optimal trading function $F^*_{\kappa_F^*}$.

They work went even further by staing the expected events that define this curvature level.

Which is when the transactional trading volume poderado by the pool value is at its highest level.

The work is to test this staments usign econometric tools to determine if this events can work as an oracle to manually adjust the curvature level to the already defined parametric trading function $F_{\kappa_F}$.

To do this we prooced with the following:

**Step 1 Test for $\text{Traders Preference Measure on}\  X \ \vee \ Y > \phi$**

The equilibrium model states that traders are incentivized to trade when they expected payoff function is positive, and this is where the expected utility of trading is greater that they cost they face.

In the DEX enviromment we identify costs as gast cost (transaction cost) and slippage cost (which is defined by the fees of the pool).

This result can be summarized as 
$$\text{Traders Preference Measure on} \  X \ \vee \ Y > \phi \implies \Delta X^{\text{COM}>0}$$

where $\Delta X^{\text{COM}}$ is the amount of the risky asset traded.

Therefore for a pool $i$ at time $t$, we aim to:

**Step 1.1 Define a consistent, unbiased and efficient estimator of
$\text{Traders Preference Measure on} \  X \ \vee \ Y$**

**Step 1.2- Define a one partition $1$ dummy variable**

$$\mathbb{1}^1_{it}=
\begin{cases}
 0 &  \text{Traders Preference Measure on} \  X \ \vee \ Y < \phi \\
 1 & \text{Traders Preference Measure on} \  X \ \vee \ Y \geq \phi

\end{cases}$$

**Step 1.3 Define and test the model**

$$\text{Transactional Trading Volume}_{it} = \beta_0+ \beta_1\cdot \mathbb{1}^1_{it} \\
H_0: \beta_1,\beta_0 > 0\ \wedge \ \beta_1 > \beta_0$$

<center>

**If we are succesfull in our first excercise we proceed to further segment our data.**

</center>

**Step 2 Test For Optimal Curvature**

**Step 2.1 Further Data Segementation**

We need to spot the time stamps $t$ on each of the $i-$th pools where 

$$(\frac{\text{Transactional Trading Volume}}{V_\text{Z}^{\text{POOL}}})_{it}$$

Where $V_\text{Z}^{\text{POOL}}$ is the value of the pool in a numeraire $Z$

$$V_\text{Z}^{\text{POOL}} = P_{Z/X}R_X + P_{Z/Y}R_Y$$

Where $P_{Z/X}, P_{Z/Y}$ are prices of the two assets $X,Y$ in the pool and $R_X,R_Y$ are the reserves levels of the pool.

In order to capture more than one data point per pool we deifine a threshold.

$$TH_{VOL} = \left\{\frac{\text{Transactional Trading Volume}}{V_\text{Z}^{\text{POOL}}} \mid \cdots \right\}$$

Now we further segment our data as

$$\mathbb{1}^{2}_{it} = \begin{cases}
  0 & \frac{\text{Transactional Trading Volume}}{V_\text{Z}^{\text{POOL}}} \notin TH_{VOL} \\
  1 & \frac{\text{Transactional Trading Volume}}{V_\text{Z}^{\text{POOL}}} \in TH_{VOL} 
\end{cases}$$



$$\Pi^{LP}_{it} = \beta_0 + \beta_1 \mathbb{1}^{1}_{it}+ \beta_2 \mathbb{1}^{2}_{it} + \beta_{12}\mathbb{1}^{12}_{it} \\

H_0: \beta_{12} = 0$$

If we are successful i.e ($\beta_{12}=0$), we have enough evidence to set bid an ask prices according to the curvature level given that

$$\kappa_F = \frac{\partial P_{Y/X}^{BID/ASK}}{\partial \Delta X}$$

To periodically adjust the trading function to the socailly optimal trading function in case the market itself fails to do so.

But... We have the parametric trading function defined as

$$F_{\kappa_F} = (1-\kappa_F)(R_X+R_Y) + \kappa_F(R_X\cdot R_Y)$$

However the above test goal is to capture the conditions from where the trading function is  supposed to be at its social optimal level. (i.e where the curvature is optimal).

The following questions are
Given that in Uniswap V2 and Sushiswap the trading function is

$$F(R_X,R_Y) = R_X\cdot R_Y$$

**Questions**

1. How do we obtain the curvature at any point in time given the state variables of the contracts?
   - We know that
 -
$$\kappa_F = \frac{\partial P_{Y/X}^{BID/ASK}}{\partial \Delta X}$$
2. How do we obtain what the optimal curvature should be as a function of the state variables?
3. Define a functional relationship between trading volume and curvature that allows us to asses a distance between the current curvature level and the optimal one
$$\forall_t \, d(\kappa_F, \kappa_F^*)_t$$
4. To save gas instead of sigle value $(\kappa_F)_t$ we define an interval from where the current curvature is defined as optimal $I^*(\kappa_F)$
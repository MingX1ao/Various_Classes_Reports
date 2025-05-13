# Homework 6

## 1 两种不同情况下的多普勒频移

首先推导通用公式

第一次，探头发射超声，血细胞接受超声，即$v_s=0,v_r=v$，运动夹角为$\phi$，那么
$$
f_1 = \frac{c+v\cos\phi}{c}f_0
$$
第二次，血细胞反射超声成为波源，换能器接受超声，即$v_s=v,v_r=0$，夹角为$\phi$，那么
$$
f_2 = \frac{c}{c-v\cos\phi}f_1
$$
代入得到$f_2 = \frac{c+v\cos\phi}{c-v\cos\phi}f_0$，得到
$$
\Delta f = f_2-f_0 = \left(\frac{c^2+2cv\cos\phi+v^2\cos^2\phi}{c^2-v^2\cos^2\phi}-1\right) f_0
$$
考虑到$c^2\gg v^2$，简化上式为
$$
\Delta f = \frac{2v\cos\phi}{c}f_0
$$
$c^2\gg v^2$的条件比$c\gg v$的条件更宽松，但后者更准确，因为声速确实远大于血液流速



### 1.1 血液远离探头

此时$\phi=120^\circ$，带入公式得到
$$
\Delta f = -227.3\,\mathsf{Hz}
$$


### 1.2 血液靠近探头

此时$\phi=60^\circ$，带入公式得到
$$
\Delta f = 227.3\,\mathsf{Hz}
$$


## 2 多普勒频移，角频率的期望和方差推导

### 2.1 多普勒频移

* 波源不动，观察者动

$f_R=\frac{c_R}{\lambda_R}$，这里只有c变了，$c_R=c+v_R,f_R=\frac{c+v_R}{c}\cdot f_0$

* 波源动，观察者不动

$f_R=\frac{c_R}{\lambda_R}$，这里只有λ变了，相邻的波峰之间间隔定义为λ，那么$\lambda_R=\lambda-T\cdot v_s,f_R=\frac{c}{c-v_s}\cdot f_0$

* 都动

综合一下，$f_R=\frac{c+v_R}{c-v_s}\cdot f_0$

多普勒彩超的测量原理公式见1节



### 2.2 角频率的期望

根据期望的定义，角频率的期望为
$$
\overline{\omega_d} = \frac{\int_\infty \omega P(\omega)d\omega}{\int_\infty P(\omega)d\omega}
$$
其中$P(\omega)$是每个成分出现的频率，也就是傅里叶变换后每个频率对应的幅值，即
$$
P(\omega) = \mathscr{F}[R(t)]
$$
那么根据逆傅里叶变换的性质，存在
$$
R(0) = \int_\infty P(\omega) e^{j\omega t}d\omega|_{t=0} = \int_\infty P(\omega) d\omega
$$

$$
\frac{dR(t)}{dt} \leftrightarrow j\omega P(\omega)=P_1(\omega)
$$

那么
$$
\int_\infty \omega P(\omega)d\omega = -j\int_\infty  P_1(\omega)d\omega = -j\frac{dR(t)}{dt}|_{t=0}=-jR'(0)
$$
合并三式，得到
$$
\overline{\omega_d} = -j\frac{R'(0)}{R(0)}
$$
根据自相关函数，可以得到
$$
R'(0) = jA(0)\Phi'(0)\,,\,\, R(0)=A(0)
$$
代回上式，得到
$$
\overline{\omega_d} = \Phi'(0) = \lim\limits_{\Delta t \rightarrow 0} \frac{\Phi(\Delta t)-\Phi(0)}{\Delta t} \approx \frac{\Phi(T)-\Phi(0)}{T} = \frac{\Phi(T)}{T}
$$



### 2.3 角频率的方差

期望与方差之间存在关系式
$$
D(X) = E(X^2) - E^2(X)
$$
$E(\omega)$已知，下面求$E(\omega^2)$

代入定义式，得到
$$
E(\omega^2) = \frac{\int_\infty \omega^2 P(\omega)d\omega}{\int_\infty P(\omega)d\omega}
$$
同样的
$$
-\frac{d^2R(t)}{dt^2} \leftrightarrow \omega^2 P(\omega)=P_2(\omega)
$$
那么
$$
E(\omega^2) = -\frac{R''(0)}{R(0)}
$$
同2.2理，将导数展开，全部代入后得到
$$
D(\omega) = \frac{2}{T^2}\left[ \frac{R^2(T)/2+R(0)R(T)-R(2T)R(0)}{R^2(0)} \right]
$$
根据定义进一步化简得到
$$
D(\omega) = \frac{2}{T^2}\left[ 1- \frac{|R(T)|}{R(0)} \right]
$$



## 3 正交信号的解调过程

接收到的回波信号为
$$
R_D = B\cos(\omega_0 t+\omega_dt+\varphi_d)
$$
其中$\omega_0 \gg \omega_d$

将发射信号$R_0=\cos(\omega_0t)$与回波信号相乘，得到
$$
R_t = B\cos(\omega_0 t+\omega_dt+\varphi_d)\cos(\omega_0t)
$$
使用积化和差公式处理上式，得到
$$
R_t = \frac{B}{2}\left[ \cos(2\omega_0t + \omega_dt+\varphi_d) +\cos(\omega_dt+\varphi_d)\right]
$$
前一项的频率远大于后一项，可以用低通滤波进行过滤，最后得到
$$
R_{filtered} = \frac{B}{2}\cos(\omega_dt + \varphi_d)
$$
还可以从频域上理解：

乘以原始信号相当于将回波信号的频谱分别向左右平移$\omega_o$（根据傅里叶变换的卷积定理），向右频移得到更大的频率成分，而向左频移将回波信号中心化，需要的成分都在低频

使用低通滤波就能得到多普勒频移成分





## 4 时域自相关法的详细推导

### 4.1 定义

时域自相关函数定义  
$$
R(\tau)=E[s(t)s^*(t+\tau)],
$$
对于某一偏移频率成分，$R(\tau)$ 可表示为  
$$
R(\tau)=R(0)\,E(e^{j\omega\tau})=R(0)\int p(\omega) e^{j\omega\tau}d\omega
         =|R(\tau)|e^{j\Phi(\tau)}
$$
其中 $\Phi(\tau)$ 为 $R(\tau)$ 的相位



### 4.2 期望
由自相关相位展开
$$
\Phi(\tau)=\arg R(\tau)=\arg E(e^{j\omega\tau})
$$
可以得到
$$
\Phi(\tau)\approx\Phi(0)+\Phi'(0)\tau
$$
考虑到 $\Phi(0)=\arg R(0)=0$，那么
$$
\Phi(\tau)\approx\Phi'(0)\tau
$$
根据2.2节的推导可以得到
$$
E(\omega)=\Phi'(0)=\lim_{\tau\to0}\frac{\Phi(\tau)-\Phi(0)}{\tau}
$$
在实际测量中，用延迟间隔 $T$ 估计导数：
$$
\Phi'(0)=\lim_{\Delta t\to0}\frac{\Phi(\Delta t)-\Phi(0)}{\Delta t}
\approx\frac{\Phi(T)-\Phi(0)}{T}
=\frac{\Phi(T)}{T}.
$$
因此，期望值的离散估计为：
$$
\bar{\omega}_d=E(\omega_d)\approx\frac{\Phi(T)}{T}
$$


import numpy as np
from scipy import stats
from sklearn.gaussian_process import GaussianProcess
from matplotlib import pyplot as pl
from matplotlib import cm
import csv

# Load training data from the file matlab generates
traindata = np.genfromtxt('stratus125_sim.csv', delimiter=',', skip_header=1,
                          missing_values=['NaN', 'nan'], filling_values=None)

# Trim the data of all times nothing was reported (this also trims the
# parts in the beginning and end where the RLS doesn't function)
traindata = traindata[np.logical_not(np.isnan(traindata[:, 2])), :]

# downsample the traindata:
traindata = traindata[np.arange(0, traindata.shape[0], 18), :]

trainx = traindata[:, 0:2]
trainy = traindata[:, 2].reshape((trainx.shape[0], 1))
traindata = None

# Create a gaussian process class
# nugget is the parameter that defines how much regularization there is
gp = GaussianProcess(theta0=5e-1, thetaL=1e-3, thetaU=3,
                     nugget=1e-12)

# train this class on the data
print('training...')
gp.fit(trainx, trainy)

# Discard all training data to preserve memory
trainx = trainy = None


# Test data
testdata = np.genfromtxt('stratus125_rival.csv', delimiter=',', skip_header=1,
                         missing_values=['NaN', 'nan'], filling_values=None)
testdata = testdata[np.logical_not(np.isnan(testdata[:, 2])), :]  # trim
testdata = testdata[np.arange(0, testdata.shape[0], 18), :]  # downsample

testx = testdata[:, 0:2]
testy = testdata[:, 2].reshape((testx.shape[0], 1))
testdata = None

predicty = gp.predict(testx)
print(np.mean(predicty[np.equal(testy, -1)]))
print(np.mean(predicty[np.equal(testy, 0)]))
print(np.mean(predicty[np.equal(testy, 1)]))
# print(predicty)

# Plot:
print('plotting...')
lim = 5
res = 50
# X axes:
x1, x2 = np.meshgrid(np.linspace(- lim, lim, res),
                     np.linspace(- lim, lim, res))
xx = np.vstack([x1.reshape(x1.size), x2.reshape(x2.size)]).T
# Y:
y_pred, MSE = gp.predict(xx, eval_MSE=True)
sigma = np.sqrt(MSE)
y_pred = y_pred.reshape((res, res))
sigma = sigma.reshape((res, res))
k = stats.distributions.norm().ppf(0.975)
PHI = stats.distributions.norm().cdf

fig = pl.figure(1)
ax = fig.add_subplot(111)
ax.axes.set_aspect('equal')
pl.xticks([])
pl.yticks([])
ax.set_xticklabels([])
ax.set_yticklabels([])
pl.xlabel('$x_1$')
pl.ylabel('$x_2$')
cax = pl.imshow(np.flipud(PHI(- y_pred / sigma)), cmap=cm.gray_r, alpha=0.8,
                extent=(- lim, lim, - lim, lim))
norm = pl.matplotlib.colors.Normalize(vmin=0., vmax=0.9)
cb = pl.colorbar(cax, ticks=[0., 0.2, 0.4, 0.6, 0.8, 1.], norm=norm)
cb.set_label('${\\rm \mathbb{P}}\left[\widehat{G}(\mathbf{x}) \leq 0\\right]$')

cs = pl.contour(x1, x2, PHI(- y_pred / sigma), [0.025], colors='b',
                linestyles='solid')
pl.clabel(cs, fontsize=11)

cs = pl.contour(x1, x2, PHI(- y_pred / sigma), [0.5], colors='k',
                linestyles='dashed')
pl.clabel(cs, fontsize=11)

cs = pl.contour(x1, x2, PHI(- y_pred / sigma), [0.975], colors='r',
                linestyles='solid')
pl.clabel(cs, fontsize=11)

pl.show()

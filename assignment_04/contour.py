from matplotlib import pyplot as plt
import numpy as np

G = np.diag([0.8, 0.4])
c = np.array([[-3, -2]]).T
def cost(x): return 0.5*np.swapaxes(x, -2, -1)@G@x + c.T @ x


d = np.linspace(-5, 10, 51)
x1, x2 = np.meshgrid(d, d)
x_vec = np.stack((x1, x2), axis=-1)[..., None]
f_x = np.squeeze(cost(x_vec))

x = d
y1 = 8-2*x
y2 = (15-x)/3
plt.contour(x1, x2, f_x, 30)
plt.plot(x, y1, x, y2, color='k')
plt.axvline(x=0, color='k')
plt.axhline(y=0, color='k')
plt.xlim(-1, 8)
plt.ylim(-1, 8)
plt.gca().set_aspect('equal')

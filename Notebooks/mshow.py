import matplotlib as mpl
import matplotlib.colors as mcolors


def mshow(A, ax=None, fill_kws={}, text_kws={}, text_cmap="binary"):
    #  <0 mapea a rojos, ~0 a blancos y >0 a azules
    fill_kws.setdefault("cmap", "RdBu")
    fill_kws.setdefault("norm", mpl.colors.CenteredNorm())
    text_kws = {"va": "center", "ha": "center", "size": 24, **text_kws}
    plt.matshow(A, **fill_kws)
    plt.colorbar()
    S = A.round(2).astype(str)  # textos
    C = mpl.colormaps[text_cmap](mpl.colors.Normalize(vmin=0)(np.abs(A)))  # color letra
    for i in range(A.shape[0]):
        for j in range(A.shape[1]):
            plt.text(x=j, y=i, s=S[i, j], c=C[i, j], **text_kws)
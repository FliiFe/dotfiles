import matplotlib as mpl
from sage.repl.rich_output import get_display_manager
from sage.repl.rich_output.output_catalog import OutputImagePng,OutputLatex,OutputPlainText,OutputImageGif

dm = get_display_manager()
old_backend_displayhook = dm._backend.displayhook

display_cmd = 'magick {0} -colorspace HSL -channel L +fx \'g == 0 ? 1 - b : b + 0.1\' -channel S +fx \'s*0.75\' +channel -colorspace sRGB -fuzz 2% -transparent black -trim - | kitty +kitten icat'

def dh(plain_text, rich_output):
    if isinstance(rich_output, OutputImagePng):
        filename = rich_output.png.filename(ext='png')
        plain_text_str = plain_text.text.get_str()
        print('')
        os.system(display_cmd.format(filename))
        return ({'text/plain': ''}, {})
    if isinstance(rich_output, OutputImageGif):
        filename = rich_output.gif.filename(ext='gif')
        plain_text_str = plain_text.text.get_str()
        print('')
        os.system(display_cmd.replace(' -trim', '').format(filename))
        return ({'text/plain': ''}, {})
    return old_backend_displayhook(plain_text, rich_output)

dm._backend.displayhook = dh

from sage.plot.plot3d.base import SHOW_DEFAULTS,Graphics3d
SHOW_DEFAULTS['viewer'] = 'tachyon'

from sage.plot.graphics import Graphics
Graphics.SHOW_OPTIONS['transparent'] = True
Graphics.SHOW_OPTIONS['dpi'] = 140

Graphics.LEGEND_OPTIONS['framealpha'] = 0

mpl.rc('text', usetex=True)

def show_latex_rendered(obj):
    text('$\\displaystyle {0}$'.format(latex(obj)), (0,0), color='black', fontsize=20).show(axes=False, transparent=True, figsize=(8,0.7))


# vim: set ft=python:

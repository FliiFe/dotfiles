# vim: syntax=perl
$cleanup_includes_cusdep_generated = 1;
$pdf_previewer = "start zathura %O %S";
$pdflatex = "pdflatex --shell-escape -interaction=nonstopmode %O %S";
# Custom dependency and function for nomencl package
add_cus_dep( 'nlo', 'nls', 0, 'makenlo2nls' );
sub makenlo2nls {
    system( "makeindex -s nomencl.ist -o \"$_[0].nls\" \"$_[0].nlo\"" );
}

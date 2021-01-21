#' bernie grob
#' @import png
#' @export geom_bernie
#'
#' @export

# copied format from https://github.com/ariespirgel/ggnba

bernieGrob <- function(x, y, size, theme) {

  img <- as.raster(png::readPNG('inst/bernie.png'))

  grid::rasterGrob(x             = x,
                   y             = y,
                   image         = img,
                   default.units = "native",
                   height        = size,
                   width         = size*0.5)
}


#' Geombernie
#'
Geombernie <- ggplot2::ggproto("Geombernie", ggplot2::Geom,

                            #draw_panel = function(., data, scales, coordinates, ...) {
                            draw_panel = function(data, panel_scales, coord, na.rm = FALSE) {
                              coords = coord$transform(data, panel_scales)
                              ggplot2:::ggname("geom_bernie",
                                             bernieGrob(coords$x, coords$y,
                                                        coords$size, coords$theme)
                              )
                            },

                            non_missing_aes = c("size", "theme"),
                            required_aes = c("x", "y"),
                            default_aes = ggplot2::aes(size=0.25, theme="airbnb"),

                            icon = function(.){}, # a grob representing the geom for the webpage

                            desc_params = list( # description of the (optional) parameters of draw
                            ),

                            seealso = list(
                              geom_point = ggplot2::GeomPoint$desc
                            ),

                            examples = function(.) {
                            }
)


#' geom_bernie
#'
#'Add image of bernie to ggplot
#'
#'@export
#'
geom_bernie <- function(mapping = NULL, data = NULL, stat = "identity",
                     position = "identity", na.rm = FALSE,
                     show.legend = NA, inherit.aes = TRUE, ...) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = Geombernie,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}

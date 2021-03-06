#' Bar Chart Cat Cat Num
#'
#' This chart does not allow for chaning orientation
#'
#' @param data A data.frame
#' @inherit dsvizopts::dsviz_default_opts
#' @inheritDotParams dsvizopts::dsviz_default_opts
#' @section ctypes:
#' Cat-Cat-Num
#' @examples
#' gg_bar_CatNum(sample_data("Cat-Num", nrow = 10))
#' @export
gg_bar_CatCatNum <- function(data, ...){

  if (is.null(data)) stop("need dataset to visualize")
  opts <- dsvizopts::merge_dsviz_options(...)

  l <- ggmagic_prep(data, opts)

  d <- l$d

  ggpos <- "stack"
  if(l$extra$graph_type == "grouped")
    ggpos <- position_dodge2(width = 0.9, preserve = "single")

  #gg <- ggplot(l$d, aes(x = a, y = c, fill = ..colors ))
  gg <- ggplot(l$d, aes(x = a, y = c, fill = b )) +
    geom_bar(stat = "identity", position = ggpos) +
    scale_fill_identity() +
    labs(title = l$titles$title,
         subtitle = l$titles$subtitle,
         caption = l$titles$caption,
         x = l$titles$x,
         y = l$titles$y,
         fill = l$titles$legend) +
    scale_y_continuous(labels = l$formats$f_nums) +
    scale_fill_manual(values=l$d$..colors, labels = l$formats$f_cat)


  if (l$dataLabels$show) {
    labpos <- d$..labpos
    gg <- gg + geom_text(aes(y = labpos,
                             label = l$dataLabels$f_nums(c)),
                         check_overlap = TRUE,
                         size = l$dataLabels$size,
                         color = l$dataLabels$color,
                         position = l$dataLabels$f_label_position)
  }

  if (l$orientation == "hor")
    gg <- gg + coord_flip()

  gg <- gg + add_ggmagic_theme(opts$theme)
  add_branding_bar(gg, opts$theme)

}

#' Bar Chart Cat Cat
#'
#' This chart does not allow for chaning orientation
#'
#' @param data A data.frame
#' @examples
#' gg_bar_CatCat(sample_data("Cat-Cat", nrow = 10))
#' @export
gg_bar_CatCat <- gg_bar_CatCatNum

all_x <- seq(from=-10,to=10,length.out=100)
all_y <- x^2 - 5*x
extend_x <- seq(from=-10,to=100,length.out=1000)
plot(all_x,all_y)

data <- tibble::tibble(all_x,all_y) %>%
  dplyr::rename("x" = all_x, "y" = all_y)

subset <- data %>% dplyr::sample_frac(.05) %>%
  dplyr::rename("x" = all_x, "y" = all_y)
readr::write_rds(subset, "~/Maths/Sheffield/dissertation/BookdownTemplate/Dissertation/data/subset.rds")


subset %>% dplyr::rename("Samples" = y) %>%
  dplyr::right_join(data, b = "x") %>%
  ggplot2::ggplot(ggplot2::aes(x=x,y=y)) +
  ggplot2::geom_line() + ggplot2::theme_bw() +
  ggplot2::geom_point(ggplot2::aes(y = Samples),col= "blue",size=2)


mod <- RobustGaSP::rgasp(design = as.matrix(subset$x), response = subset$y,
                zero.mean = "No",
                nugget.est =F )
p <-  predict(mod, all_x, X = mod@X)
preds_mod <- tibble::tibble(mean = p$mean, lower95 = p$lower95,
                            upper95 = p$upper95, x= all_x) %>%
  dplyr::left_join(subset,by="x")

library(ggplot2)
preds_mod %>% ggplot(aes(x=x,y = mean)) + geom_line() +
  geom_line(aes(y=upper95), color="red") +
  geom_line(aes(y=lower95), color="red") +
  geom_point(aes(y=y))


mod_zero <- RobustGaSP::rgasp(design = as.matrix(subset$x), response = subset$y,
                       zero.mean = "Yes",
                       nugget.est = F)
p_zero <-  predict(mod_zero, all_x, X = mod_zero@X)
preds_mod_zero <- tibble::tibble(mean = p_zero$mean, lower95 = p_zero$lower95,
                            upper95 = p_zero$upper95, x= all_x) %>%
  dplyr::left_join(subset,by="x")

preds_mod_zero %>% ggplot(aes(x=x,y = mean)) + geom_line() +
  geom_line(aes(y=upper95), color="red") +
  geom_line(aes(y=lower95), color="red") +
  geom_point(aes(y=y))



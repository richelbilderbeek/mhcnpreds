t2 <- readr::read_csv("ic50s_v0_2.csv")
t3 <- readr::read_csv("ic50s_v0_3.csv")

haplotype <- mhcnuggetsr::to_mhcnuggets_name(bbbq::get_mhc1_haplotypes()[1])
haplotype

haplotypes <- mhcnuggetsr::to_mhcnuggets_name(bbbq::get_mhc_haplotypes())


ic50s_2 <- t(t2[t2$haplotype == haplotype, -1])
ic50s_3 <- t(t3[t3$haplotype == haplotype, -1])

hist(ic50s_2)
hist(ic50s_3)

t2$version <- 2
t3$version <- 3
t <- rbind(t2, t3)
t$haplotype <- as.factor(t$haplotype)
t$version <- as.factor(t$version)

library(ggplot2)


library(dplyr)
ggplot(
  t %>% dplyr::filter(haplotype %in% haplotypes),
  aes(x = haplotype, y = p100, fill = version)
) + geom_col(position = "dodge") +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)
  ); ggsave("compare_versions_p100.png", width = 7, height = 7)




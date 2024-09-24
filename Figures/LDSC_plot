## Load modules

library(ggplot2)
library(readxl)

## Load data

dat<-read_xlsx("Heatmaps.xlsx", sheet="LDSC")

## Create the LDSC heatmap

ggplot(data = dat, aes(x=Cancer, y=`Glioma Subtype`, fill=`Genetic Correlation (rg)`)) +
  geom_tile(color="white", lwd=0.5) +
  scale_fill_gradient(low = "white", high = "red") +
  coord_fixed() +
  labs(fill=expression("R"[g])) +
  theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust = 1), text = element_text(size = 14))

## Save the plot

ggsave("LDSC.png",units = "in", width=12, height=4, dpi=1200)

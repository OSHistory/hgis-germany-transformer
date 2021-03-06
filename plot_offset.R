
library(yaml)

# Function from:
# https://stackoverflow.com/questions/4787332/how-to-remove-outliers-from-a-dataset
remove_outliers <- function(x, na.rm = TRUE, ...) {
  qnt <- quantile(x, probs=c(.05, .95), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}

dim.size <- 960
dfr <- read.csv("dist_vals_sn.csv", header=FALSE)
# dfr$V2 <- remove_outliers(dfr$V2)
# dfr <- dfr[!is.na(dfr$V2),]

png("offset_plot_sn.png", height=dim.size, width=dim.size)
plot(
  dfr$V2 ~ dfr$V1,
  ylab="Abweichung",
  xlab="Breitengrad"
  )

fit.defun.sn.simple <- lm(dfr$V2 ~ dfr$V1)
abline(fit.defun.sn.simple)
dev.off()

fileConn <- file("coeff-linear-sn.yaml")
writeLines(as.yaml(fit.defun.sn.simple$coefficients), fileConn)
close(fileConn)

## EAST-WEST
dfr <- read.csv("dist_vals_we.csv", header=FALSE)

png("offset_plot_we.png", height=dim.size, width=dim.size)
plot(
  dfr$V2 ~ dfr$V1,
  ylab="Abweichung",
  xlab="Längengrad"
)
fit.defun.we.simple <- lm(dfr$V2 ~ dfr$V1)
abline(fit.defun.we.simple)
dev.off()

fileConn <- file("coeff-linear-we.yaml")
writeLines(as.yaml(fit.defun.we.simple$coefficients), fileConn)
close(fileConn)

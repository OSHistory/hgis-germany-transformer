
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
print("Plotting South-North")
dfr <- read.csv("dist_vals_sn.csv", header=FALSE)

png("offset_plot_sn.png", height=dim.size, width=dim.size)
plot(
  dfr$V2 ~ dfr$V1,
  ylab="Abweichung",
  xlab="Breitengrad"
  )

abline(lm(dfr$V2 ~ dfr$V1))
print(lm(dfr$V2 ~ dfr$V1))

dev.off()


print("Plotting West-East")
dfr <- read.csv("dist_vals_we.csv", header=FALSE)

# dfr$V2 <- remove_outliers(dfr$V2)

png("offset_plot_we.png", height=dim.size, width=dim.size)
plot(
  dfr$V1 ~ dfr$V2,
  xlab="Abweichung",
  ylab="Längengrad"
)
fit.defun.we.simple <- lm(dfr$V2 ~ dfr$V1)
# fit.defun.we.simple <- lm(dfr$V1 ~ log(dfr$V2))
abline(fit.defun.we.simple)
print(fit.defun.we.simple)
dev.off()

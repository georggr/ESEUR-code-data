#
# BSD-dtw.R, 20 Feb 16
#
# Data from:
#
# A statistical examination of the properties and evolution of libre software
# Israel Herraiz Tabernero
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library("dtw")
library("plyr")

plot_wide()

pal_col=rainbow(2)


freebsd=read.csv(paste0(ESEUR_dir, "regression/Herraiz-freebsd.txt.xz"), as.is=TRUE)
netbsd=read.csv(paste0(ESEUR_dir, "regression/Herraiz-netbsd.txt.xz"), as.is=TRUE)
# postgresql=read.csv(paste0(ESEUR_dir, "regression/Herraiz-postgresql.txt.xz"), as.is=TRUE)


plot_acf=function(lines)
{
sloc_diff=diff(lines)

# t=acf(sloc_diff, lag=175, plot=FALSE)
# plot(t, xlab="Lag (days)")

weeks=aaply(seq(1, length(lines), by=7), 1,
			function(X) sum(lines[X:(X+6)], na.rm=TRUE))

# t=acf(diff(weeks), plot=FALSE)
# plot(t, xlab="Lag (weeks)")

return(head(weeks, -1))
}


freebsd_weeks=plot_acf(freebsd$sloc)
netbsd_weeks=plot_acf(netbsd$sloc)
# psql_weeks=plot_acf(postgresql$sloc)

bsd_align=dtw(freebsd_weeks, netbsd_weeks, keep=TRUE,
		step=asymmetric, open.end=TRUE, open.begin=TRUE)
plot(bsd_align, type="twoway", offset=1, col=pal_col, cex.lab=1.5,
	xlab="Weeks", ylab="FreeBSD\n")

# bsd_align=dtw(psql_weeks, freebsd_weeks,
# 		keep=TRUE, step=asymmetric, open.end=TRUE, open.begin=TRUE)
# plot(bsd_align, type="twoway", offset=1)



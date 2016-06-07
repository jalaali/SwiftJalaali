# Jalaali Swift

A few Swift functions for converting Jalaali (Jalali, Persian, Khayyami, Khorshidi, Shamsi) and Gregorian calendar systems to each other.

## About

Jalali calendar is a solar calendar that was used in Persia, variants of which today are still in use in Iran as well as Afghanistan. [Read more on Wikipedia](http://en.wikipedia.org/wiki/Jalali_calendar) or see [Calendar Converter](http://www.fourmilab.ch/documents/calendar/).

Calendar conversion is based on the [algorithm provided by Kazimierz M. Borkowski](http://www.astro.uni.torun.pl/~kb/Papers/EMP/PersianC-EMP.htm) and has a very good performance.

## Install

Use [Carthage](https://github.com/Carthage/Carthage) to build and install.

## API

### func toJalaali(gy: GregorianYear, _ gm: GregorianMonth, _ gd: GregorianDay) -> JalaaliDate

Converts a Gregorian date to Jalaali.


### func toGregorian(jy: JalaaliYear, _ jm: JalaaliMonth, _ jd: JalaaliDay) -> GregorianDate

Converts a Jalaali date to Gregorian.


### func isValidJalaaliDate(jy: JalaaliYear, _ jm: JalaaliMonth, _ jd: JalaaliDay) -> Bool

Checks whether a Jalaali date is valid or not.


### func isLeapJalaaliYear(jy: JalaaliYear) -> Bool {

Is this a leap year or not?


### func lastDayOfJalaaliMonth(jy: JalaaliYear, _ jm: JalaaliMonth) -> JalaaliDay

Number of days in a given month in a Jalaali year.


### typealias JalaaliDate = (year: JalaaliYear, month: JalaaliMonth, day: JalaaliDay)

A tuple for a Jalaali date.


### typealias GregorianDate = (year: GregorianYear, month: GregorianMonth, day: GregorianDay)

A tuple for a Gregorian date.


### typealias JalaaliYear = Int

An Int representing a Jalaali year.


### typealias JalaaliMonth = Int

An Int representing a Jalaali month (1-based).


### typealias JalaaliDay = Int

An Int representing a Jalaali day.


### typealias GregorianYear = Int

An Int representing a Gregorian year.


### typealias GregorianMonth = Int

An Int representing a Gregorian month (1-based).


### typealias GregorianDay = Int

An Int representing a Gregorian day.


### typealias JulianDayNumber = Int

An Int representing a Julian Day Number


## License

MIT

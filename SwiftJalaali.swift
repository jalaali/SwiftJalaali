/// An Int representing a Jalaali year.
public typealias JalaaliYear = Int

/// An Int representing a Jalaali month (1-based).
public typealias JalaaliMonth = Int

/// An Int representing a Jalaali day.
public typealias JalaaliDay = Int

/// An Int representing a Gregorian year.
public typealias GregorianYear = Int

/// An Int representing a Gregorian month (1-based).
public typealias GregorianMonth = Int

/// An Int representing a Gregorian day.
public typealias GregorianDay = Int

/// An Int representing a Julian Day Number
public typealias JulianDayNumber = Int

/// A tuple for a Jalaali date.
public typealias JalaaliDate = (year: JalaaliYear, month: JalaaliMonth, day: JalaaliDay)

/// A tuple for a Gregorian date.
public typealias GregorianDate = (year: GregorianYear, month: GregorianMonth, day: GregorianDay)

// Jalaali years starting the 33-year rule.
let breaks =  [ -61, 9, 38, 199, 426, 686, 756, 818, 1111, 1181, 1210
  , 1635, 2060, 2097, 2192, 2262, 2324, 2394, 2456, 3178
]

/// This function determines if the Jalaali (Persian) year is
/// leap (366-day long) or is the common year (365 days), and
/// finds the day in March (Gregorian calendar) of the first
/// day of the Jalaali year (jy).
///
/// @param jy Jalaali calendar year (-61 to 3177)
/// @return
///   leap: number of years since the last leap year (0 to 4)
///   gy: Gregorian year of the beginning of Jalaali year
///   march: the March day of Farvardin the 1st (1st day of jy)
/// @see: http://www.astro.uni.torun.pl/~kb/Papers/EMP/PersianC-EMP.htm
/// @see: http://www.fourmilab.ch/documents/calendar/
func jalCal(jy: JalaaliYear) -> (leapOffset: Int, year: GregorianYear, dayInMarch: Int) {
  assert(jy >= breaks.first, "invalid jalaali year \(jy), should be >= \(breaks.first)")
  assert(jy < breaks.last, "invalid jalaali year \(jy), should be < \(breaks.last)")
  
  let gy = jy + 621
  var leapJ = -14
  let jump = 0
  
  // Find the limiting years for the Jalaali year jy.
  var jp = breaks[0]
  for i in 1 ..< breaks.count {
    let jm = breaks[i]
    let jump = jm - jp
    if jy < jm {
      break
    }
    leapJ += jump / 33 * 8 + jump % 33 / 4
    jp = jm
  }
  var n = jy - jp
  
  // Find the number of leap years from AD 621 to the beginning
  // of the current Jalaali year in the Persian calendar.
  leapJ += n / 33 * 8 + (n % 33 + 3) / 4
  if jump % 33 == 4 && jump - n == 4 {
    leapJ += 1
  }
  
  // And the same in the Gregorian calendar (until the year gy).
  let leapG = gy / 4 - ((gy / 100) + 1) * 3 / 4 - 150
  
  // Determine the Gregorian date of Farvardin the 1st.
  let march = 20 + leapJ - leapG
  
  // Find how many years have passed since the last leap year.
  if jump - n < 6 {
    n = n - jump + (jump + 4) / 33 * 33
  }
  var leap = ((n + 1) % 33 - 1) % 4
  if leap == -1 {
    leap = 4
  }
  
  return (leap, gy, march)
}

/// Converts a date of the Jalaali calendar to the Julian Day number.
///
/// @param jy Jalaali year (1 to 3100)
/// @param jm Jalaali month (1 to 12)
/// @param jd Jalaali day (1 to 29/31)
/// @return Julian Day number
func j2d(jy: JalaaliYear, _ jm: JalaaliMonth, _ jd: JalaaliDay) -> JulianDayNumber {
  let r = jalCal(jy)
  let t = g2d(r.year, 3, r.dayInMarch) + (jm - 1) * 31
  return t - jm / 7 * (jm - 7) + jd - 1
}

/// Converts the Julian Day number to a date in the Jalaali calendar.
///
/// @param jdn Julian Day number
/// @return
///   jy: Jalaali year (1 to 3100)
///   jm: Jalaali month (1 to 12)
///   jd: Jalaali day (1 to 29/31)
func d2j(jdn: JulianDayNumber) -> JalaaliDate {
  let gy = d2g(jdn).year // Calculate Gregorian year (gy).
  var jy = gy - 621
  let r = jalCal(jy)
  let jdn1f = g2d(gy, 3, r.dayInMarch)
  var jd, jm, k: Int
  
  // Find number of days that passed since 1 Farvardin.
  k = jdn - jdn1f
  if k >= 0 {
    if k <= 185 {
      // The first 6 months.
      jm = 1 + k / 31
      jd = k % 31 + 1
      return (jy, jm, jd)
    } else {
      // The remaining months.
      k -= 186
    }
  } else {
    // Previous Jalaali year.
    jy -= 1
    k += 179
    if r.leapOffset == 1 {
      k += 1
    }
  }
  jm = 7 + k / 30
  jd = k % 30 + 1
  return (jy, jm, jd)
}

/// Calculates the Julian Day number from Gregorian or Julian
/// calendar dates. This integer number corresponds to the noon of
/// the date (i.e. 12 hours of Universal Time).
/// The procedure was tested to be good since 1 March, -100100 (of both
/// calendars) up to a few million years into the future.
///
/// @param gy Calendar year (years BC numbered 0, -1, -2, ...)
/// @param gm Calendar month (1 to 12)
/// @param gd Calendar day of the month (1 to 28/29/30/31)
/// @return Julian Day number
func g2d(gy: GregorianYear, _ gm: GregorianMonth, _ gd: GregorianDay) -> JulianDayNumber {
  var d = (gy + (gm - 8) / 6 + 100100) * 1461 / 4
    + (153 * ((gm + 9) % 12) + 2) / 5
    + gd - 34840408
  d = d - (gy + 100100 + (gm - 8) / 6) / 100 * 3 / 4 + 752
  return d
}

/// Calculates Gregorian and Julian calendar dates from the Julian Day number
/// (jdn) for the period since jdn=-34839655 (i.e. the year -100100 of both
/// calendars) to some millions years ahead of the present.
///
/// @param jdn Julian Day number
/// @return
///   gy: Calendar year (years BC numbered 0, -1, -2, ...)
///   gm: Calendar month (1 to 12)
///   gd: Calendar day of the month M (1 to 28/29/30/31)
func d2g(jdn: JulianDayNumber) -> GregorianDate {
  var j = 4 * jdn + 139361631
  j += (4 * jdn + 183187720) / 146097 * 3 / 4 * 4 - 3908
  let i = j % 1461 / 4 * 5 + 308
  let gd = i % 153 / 5 + 1
  let gm = i / 153 % 12 + 1
  let gy = j / 1461 - 100100 + (8 - gm) / 6
  return (gy, gm, gd)
}

/// Converts a Gregorian date to Jalaali.
public func toJalaali(gy: GregorianYear, _ gm: GregorianMonth, _ gd: GregorianDay) -> JalaaliDate {
  return d2j(g2d(gy, gm, gd))
}

/// Converts a Jalaali date to Gregorian.
public func toGregorian(jy: JalaaliYear, _ jm: JalaaliMonth, _ jd: JalaaliDay) -> GregorianDate {
  return d2g(j2d(jy, jm, jd))
}

/// Checks whether a Jalaali date is valid or not.
public func isValidJalaaliDate(jy: JalaaliYear, _ jm: JalaaliMonth, _ jd: JalaaliDay) -> Bool {
  return  jy >= breaks.first && jy < breaks.last &&
    jm >= 1 && jm <= 12 &&
    jd >= 1 && jd <= lastDayOfJalaaliMonth(jy, jm)
}

/// Is this a leap year or not?
public func isLeapJalaaliYear(jy: JalaaliYear) -> Bool {
  return jalCal(jy).leapOffset == 0
}

/// Number of days in a given month in a Jalaali year.
public func lastDayOfJalaaliMonth(jy: JalaaliYear, _ jm: JalaaliMonth) -> JalaaliDay {
  if jm <= 6 { return 31 }
  if jm <= 11 { return 30 }
  if isLeapJalaaliYear(jy) { return 30 }
  return 29
}

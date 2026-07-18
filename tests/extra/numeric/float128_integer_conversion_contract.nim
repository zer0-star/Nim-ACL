import std/strutils
import atcoder/extra/numeric/int128
import atcoder/extra/numeric/int256
import atcoder/extra/numeric/float128

func makeUInt128(low, high: uint64): UInt128 =
  toUInt128(low) or (toUInt128(high) shl 64)

func makeUInt256(
    limb0, limb1, limb2, limb3: uint64
  ): UInt256 =
  toUInt256(limb0) or
    (toUInt256(limb1) shl 64) or
    (toUInt256(limb2) shl 128) or
    (toUInt256(limb3) shl 192)

proc emitVector(
    name, sourceType: string,
    value: Float128
  ) =
  let raw = toBits(value)

  echo(
    name, "\t", sourceType, "\t",
    toHex(raw.high, 16), "\t",
    toHex(raw.low, 16)
  )

block:
  let sourceValue = makeUInt128(0x0000000000000000'u64, 0x0000000000000000'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x0000000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("u_zero", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x0000000000000001'u64, 0x0000000000000000'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x3FFF000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("u_one", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x0000000000000002'u64, 0x0000000000000000'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x4000000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("u_two", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x0000000000000003'u64, 0x0000000000000000'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x4000800000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("u_three", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x7FFFFFFFFFFFFFFF'u64, 0x0000000000000000'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x403DFFFFFFFFFFFF'u64
  doAssert raw.low == 0xFFFC000000000000'u64
  emitVector("u63_max", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x8000000000000000'u64, 0x0000000000000000'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x403E000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("u64_min", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0xFFFFFFFFFFFFFFFF'u64, 0x0000000000000000'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x403EFFFFFFFFFFFF'u64
  doAssert raw.low == 0xFFFE000000000000'u64
  emitVector("u64_max", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x0000000000000000'u64, 0x0000000000000001'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x403F000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("u65_min", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0xFFFFFFFFFFFFFFFF'u64, 0x0000FFFFFFFFFFFF'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x406EFFFFFFFFFFFF'u64
  doAssert raw.low == 0xFFFFFFFFFFFFFFFE'u64
  emitVector("u112_max", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x0000000000000000'u64, 0x0001000000000000'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x406F000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("u113_min", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0xFFFFFFFFFFFFFFFF'u64, 0x0001FFFFFFFFFFFF'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x406FFFFFFFFFFFFF'u64
  doAssert raw.low == 0xFFFFFFFFFFFFFFFF'u64
  emitVector("u113_max", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x0000000000000001'u64, 0x0002000000000000'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x4070000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("tie_even_shift1", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x0000000000000003'u64, 0x0002000000000000'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x4070000000000000'u64
  doAssert raw.low == 0x0000000000000002'u64
  emitVector("tie_odd_shift1", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x0000000000000001'u64, 0x0004000000000000'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x4071000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("below_half_shift2", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x0000000000000002'u64, 0x0004000000000000'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x4071000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("tie_even_shift2", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x0000000000000003'u64, 0x0004000000000000'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x4071000000000000'u64
  doAssert raw.low == 0x0000000000000001'u64
  emitVector("above_half_shift2", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x0000000000000006'u64, 0x0004000000000000'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x4071000000000000'u64
  doAssert raw.low == 0x0000000000000002'u64
  emitVector("tie_odd_shift2", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0xFFFFFFFFFFFFFFFF'u64, 0x0003FFFFFFFFFFFF'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x4071000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("carry_round_to_power", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0xFFFFFFFFFFFFFFFF'u64, 0xFFFFFFFFFFFFFFFF'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407F000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("uint128_max", "UInt128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xFFFFFFFFFFFFFFFF'u64, 0x7FFFFFFFFFFFFFFF'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407E000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("int128_max", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x0000000000000000'u64, 0x8000000000000000'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07E000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("int128_min", "Int128", converted)

block:
  let sourceValue = makeUInt256(0x0000000000000000'u64, 0x0000000000000000'u64, 0x8000000000000000'u64, 0x0000000000000000'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40BE000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("u192_exact_power", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xFFFFFFFFFFFFFFFF'u64, 0xFFFFFFFFFFFFFFFF'u64, 0xFFFFFFFFFFFFFFFF'u64, 0x0000000000000000'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40BF000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("u192_dense", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xFFFFFFFFFFFFFFFF'u64, 0xFFFFFFFFFFFFFFFF'u64, 0xFFFFFFFFFFFFFFFF'u64, 0xFFFFFFFFFFFFFFFF'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FF000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("uint256_max", "UInt256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0xFFFFFFFFFFFFFFFF'u64, 0xFFFFFFFFFFFFFFFF'u64, 0xFFFFFFFFFFFFFFFF'u64, 0x7FFFFFFFFFFFFFFF'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FE000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("int256_max", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x0000000000000000'u64, 0x0000000000000000'u64, 0x0000000000000000'u64, 0x8000000000000000'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0FE000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("int256_min", "Int256", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xFFFFFFFFFFFFFFFF'u64, 0xFFFFFFFFFFFFFFFF'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xBFFF000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("negative_one", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xFFFFFFFFFFFFFFFF'u64, 0xFFFDFFFFFFFFFFFF'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC070000000000000'u64
  doAssert raw.low == 0x0000000000000000'u64
  emitVector("negative_tie_even", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xFFFFFFFFFFFFFFFD'u64, 0xFFFDFFFFFFFFFFFF'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC070000000000000'u64
  doAssert raw.low == 0x0000000000000002'u64
  emitVector("negative_tie_odd", "Int128", converted)

block:
  let sourceValue = makeUInt128(0x9E4E592E5DC038FD'u64, 0x21D6F149FE9D9B07'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407C0EB78A4FF4EC'u64
  doAssert raw.low == 0xD83CF272C972EE02'u64
  emitVector("random_u128_00", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x44E8F10DB55CBAB5'u64, 0x92184B37F71D0F78'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407E2430966FEE3A'u64
  doAssert raw.low == 0x1EF089D1E21B6AB9'u64
  emitVector("random_u128_01", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0xE5A3F3C4427D9A94'u64, 0x7D4AAE95E9DEECDC'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407DF52ABA57A77B'u64
  doAssert raw.low == 0xB373968FCF1109F6'u64
  emitVector("random_u128_02", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0xD06B5E3B7DEBA757'u64, 0xF759FD5B9D1C4F96'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407EEEB3FAB73A38'u64
  doAssert raw.low == 0x9F2DA0D6BC76FBD7'u64
  emitVector("random_u128_03", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x3FA87796EEF7DA16'u64, 0x825AA74B8257B13A'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407E04B54E9704AF'u64
  doAssert raw.low == 0x62747F50EF2DDDF0'u64
  emitVector("random_u128_04", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x8946085A24E0F16E'u64, 0x8E2ACFDE0D761AD2'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407E1C559FBC1AEC'u64
  doAssert raw.low == 0x35A5128C10B449C2'u64
  emitVector("random_u128_05", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x7BBD49B21C2A5600'u64, 0x33293DAE05F1FD07'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407C9949ED702F8F'u64
  doAssert raw.low == 0xE83BDDEA4D90E153'u64
  emitVector("random_u128_06", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x4B7D5E01CD16E8FD'u64, 0xA1AAFD24BA4AD666'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407E4355FA497495'u64
  doAssert raw.low == 0xACCC96FABC039A2E'u64
  emitVector("random_u128_07", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x8E2218D5DFC98C91'u64, 0x4490FBCA9445342F'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407D1243EF2A5114'u64
  doAssert raw.low == 0xD0BE388863577F26'u64
  emitVector("random_u128_08", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x3678F7D23E213ABA'u64, 0x259529B5E6E1C36F'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407C2CA94DAF370E'u64
  doAssert raw.low == 0x1B79B3C7BE91F10A'u64
  emitVector("random_u128_09", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x41C2745FEC540191'u64, 0xAF3CAC2431605155'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407E5E79584862C0'u64
  doAssert raw.low == 0xA2AA8384E8BFD8A8'u64
  emitVector("random_u128_10", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x2706BD049B1306AA'u64, 0x0B0172690656DE3B'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407A602E4D20CADB'u64
  doAssert raw.low == 0xC764E0D7A0936261'u64
  emitVector("random_u128_11", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x5E30CB29C51E1F45'u64, 0x86ED627ED4D25C54'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407E0DDAC4FDA9A4'u64
  doAssert raw.low == 0xB8A8BC6196538A3C'u64
  emitVector("random_u128_12", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0xC48EE705E9668846'u64, 0x8AD9C276F31F251D'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407E15B384EDE63E'u64
  doAssert raw.low == 0x4A3B891DCE0BD2CD'u64
  emitVector("random_u128_13", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0xE499F587A4C23AEA'u64, 0xDF6C63F4E0823ABE'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407EBED8C7E9C104'u64
  doAssert raw.low == 0x757DC933EB0F4984'u64
  emitVector("random_u128_14", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0xFA8E1B188A288689'u64, 0xAF1DAB45991D97E4'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407E5E3B568B323B'u64
  doAssert raw.low == 0x2FC9F51C36311451'u64
  emitVector("random_u128_15", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x9BAE7E04B8AC8716'u64, 0xF380BE7C03403535'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407EE7017CF80680'u64
  doAssert raw.low == 0x6A6B375CFC097159'u64
  emitVector("random_u128_16", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x0376AEBCD7D9C902'u64, 0x19D4C79504AE65E3'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407B9D4C79504AE6'u64
  doAssert raw.low == 0x5E30376AEBCD7D9D'u64
  emitVector("random_u128_17", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0xD7717CF3C0B84332'u64, 0x293724FE75BA0422'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407C49B927F3ADD0'u64
  doAssert raw.low == 0x2116BB8BE79E05C2'u64
  emitVector("random_u128_18", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x9FE055BA90E9B5A7'u64, 0x34FC8160FDAA7628'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407CA7E40B07ED53'u64
  doAssert raw.low == 0xB144FF02ADD4874E'u64
  emitVector("random_u128_19", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x1766932BDE11704D'u64, 0x36E4F1B3731F3317'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407CB7278D9B98F9'u64
  doAssert raw.low == 0x98B8BB34995EF08C'u64
  emitVector("random_u128_20", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x47D498680693CF7F'u64, 0xC898F06A555792A9'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407E9131E0D4AAAF'u64
  doAssert raw.low == 0x25528FA930D00D28'u64
  emitVector("random_u128_21", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0xD4648368F3FBB909'u64, 0xCA90B0CC51D7BB27'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407E95216198A3AF'u64
  doAssert raw.low == 0x764FA8C906D1E7F7'u64
  emitVector("random_u128_22", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x4B7D93DE2E92E194'u64, 0x9D0B0D11F60DFF60'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407E3A161A23EC1B'u64
  doAssert raw.low == 0xFEC096FB27BC5D26'u64
  emitVector("random_u128_23", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0xB5B7370E4FCD75FF'u64, 0x8A12906AA353B8BF'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407E142520D546A7'u64
  doAssert raw.low == 0x717F6B6E6E1C9F9B'u64
  emitVector("random_u128_24", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0xA1EE00A85EF63A4C'u64, 0xA4C3B78966E2135F'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407E49876F12CDC4'u64
  doAssert raw.low == 0x26BF43DC0150BDEC'u64
  emitVector("random_u128_25", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x42A17197096A9D49'u64, 0xFC8BC2E90D4DC368'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407EF91785D21A9B'u64
  doAssert raw.low == 0x86D08542E32E12D5'u64
  emitVector("random_u128_26", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x52CAFE9EBEB60B82'u64, 0x294F905C6D3EFA97'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407C4A7C82E369F7'u64
  doAssert raw.low == 0xD4BA9657F4F5F5B0'u64
  emitVector("random_u128_27", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x701C4997EE2A1E56'u64, 0x08BC0BA2A52DD607'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407A17817454A5BA'u64
  doAssert raw.low == 0xC0EE038932FDC544'u64
  emitVector("random_u128_28", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x529B6937265C4F68'u64, 0x264D1176BD2A642B'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407C32688BB5E953'u64
  doAssert raw.low == 0x215A94DB49B932E2'u64
  emitVector("random_u128_29", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0x640245F1BDB90027'u64, 0x1D550A62ED9AB1C0'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407BD550A62ED9AB'u64
  doAssert raw.low == 0x1C0640245F1BDB90'u64
  emitVector("random_u128_30", "UInt128", converted)

block:
  let sourceValue = makeUInt128(0xAEB8206EE042D4F8'u64, 0xCF92B2A6ED6B393E'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407E9F25654DDAD6'u64
  doAssert raw.low == 0x727D5D7040DDC086'u64
  emitVector("random_u128_31", "UInt128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xBB538E0A0C26DCDE'u64, 0xEE0BDEE2CBBF41ED'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07B1F4211D3440B'u64
  doAssert raw.low == 0xE1244AC71F5F3D92'u64
  emitVector("random_i128_00", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x8D26A51F171DBE0B'u64, 0xD3637F08759DBB30'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07C64E407BC5312'u64
  doAssert raw.low == 0x267B96CAD7074712'u64
  emitVector("random_i128_01", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x732497DFF562CB7A'u64, 0xC6FA0E347748DC09'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07CC82F8E5C45B9'u64
  doAssert raw.low == 0x1FB466DB410054EA'u64
  emitVector("random_i128_02", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x4497737E20897F8B'u64, 0x876B99C9AEBAF2DB'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07DE25198D94514'u64
  doAssert raw.low == 0x3492EDA232077DDA'u64
  emitVector("random_i128_03", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x1188473E8C130362'u64, 0xD1489A6372D9818C'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07C75BB2CE46933'u64
  doAssert raw.low == 0xF39F73BDC60B9F68'u64
  emitVector("random_i128_04", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xA5FAB857F0A1C831'u64, 0xA3285A32A018527E'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07D735E97357F9E'u64
  doAssert raw.low == 0xB60568151EA03D79'u64
  emitVector("random_i128_05", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xE613E43BE7070597'u64, 0xA929C06D95A6DADA'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07D5B58FE49A964'u64
  doAssert raw.low == 0x949467B06F1063E4'u64
  emitVector("random_i128_06", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x9F57029B49213359'u64, 0xB627DCBF1B6F475A'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07D27608D039242'u64
  doAssert raw.low == 0xE29582A3F592DB7B'u64
  emitVector("random_i128_07", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x810BE8E7BF211799'u64, 0x0D34AD4CEAA1F7A3'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407AA695A99D543E'u64
  doAssert raw.low == 0xF470217D1CF7E423'u64
  emitVector("random_i128_08", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x743541504DFBE335'u64, 0xD946D52C8FD17E9F'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07C35C9569B8174'u64
  doAssert raw.low == 0x0B045E55F57D9021'u64
  emitVector("random_i128_09", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x5AF020F4250D2819'u64, 0xCEAF712E40822801'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07C8A84768DFBEE'u64
  doAssert raw.low == 0xBFF5287EF85ED797'u64
  emitVector("random_i128_10", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x3AFBBC42D17C158E'u64, 0xD5902AB52A9E9AE8'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07C537EAA56AB0B'u64
  doAssert raw.low == 0x28BE28221DE9741F'u64
  emitVector("random_i128_11", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x8A82F4CF1FBFC558'u64, 0x0FCB6E727C91A27D'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407AF96DCE4F9234'u64
  doAssert raw.low == 0x4FB1505E99E3F7F9'u64
  emitVector("random_i128_12", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x0E304451F05833B9'u64, 0x8F1FBCA25B0CAAA9'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07DC3810D7693CD'u64
  doAssert raw.low == 0x555BC73EEEB83E9F'u64
  emitVector("random_i128_13", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xADA697C8D0A6D65F'u64, 0xB86EBAC70C8C8AA1'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07D1E4514E3CDCD'u64
  doAssert raw.low == 0xD5794965A0DCBD65'u64
  emitVector("random_i128_14", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xC08DF7E870F91A89'u64, 0x29308C7932144B06'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407C498463C990A2'u64
  doAssert raw.low == 0x5836046FBF4387C9'u64
  emitVector("random_i128_15", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xDF203EB9E3AFFCDF'u64, 0xF318B425B009F8CC'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07A9CE97B49FEC0'u64
  doAssert raw.low == 0xE6641BF828C38A00'u64
  emitVector("random_i128_16", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xF552A11B9744B26F'u64, 0x37AC09E205FA233C'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407CBD604F102FD1'u64
  doAssert raw.low == 0x19E7AA9508DCBA26'u64
  emitVector("random_i128_17", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x410A6508ABC108A3'u64, 0x52AB584DD9A06129'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407D4AAD61376681'u64
  doAssert raw.low == 0x84A504299422AF04'u64
  emitVector("random_i128_18", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xAB5008ABCE0D061B'u64, 0x1BF1C007BF28F2F3'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407BBF1C007BF28F'u64
  doAssert raw.low == 0x2F3AB5008ABCE0D0'u64
  emitVector("random_i128_19", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x281A19CABB2706CF'u64, 0x81690F4C064D560A'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07DFA5BC2CFE6CA'u64
  doAssert raw.low == 0xA7D75F9798D51364'u64
  emitVector("random_i128_20", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xA5EEE87694450BF7'u64, 0x835DE4ABCA608AF0'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07DF2886D50D67D'u64
  doAssert raw.low == 0xD43D68445E25AEEC'u64
  emitVector("random_i128_21", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xA8E58159917DF5DA'u64, 0x49B2991EC20C9A47'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407D26CA647B0832'u64
  doAssert raw.low == 0x691EA396056645F8'u64
  emitVector("random_i128_22", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x9FA28F053A29200F'u64, 0x24B05CA4CF33F22E'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407C2582E526799F'u64
  doAssert raw.low == 0x9174FD147829D149'u64
  emitVector("random_i128_23", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xC6A9351C6E44A85B'u64, 0x7208F0F326189AF4'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407DC823C3CC9862'u64
  doAssert raw.low == 0x6BD31AA4D471B913'u64
  emitVector("random_i128_24", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xBC93B3E61A020229'u64, 0x00F578876BFDBBFE'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x4076EAF10ED7FB77'u64
  doAssert raw.low == 0xFD792767CC340404'u64
  emitVector("random_i128_25", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xC181323DB940826F'u64, 0x44E0624D87E5DAA2'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407D138189361F97'u64
  doAssert raw.low == 0x6A8B0604C8F6E502'u64
  emitVector("random_i128_26", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x1911872A20330423'u64, 0xAD193CC1833D7BBD'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07D4B9B0CF9F30A'u64
  doAssert raw.low == 0x110B9BB9E3577F34'u64
  emitVector("random_i128_27", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x96F151AC455481F6'u64, 0x29F0E69F4B8ED785'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407C4F8734FA5C76'u64
  doAssert raw.low == 0xBC2CB78A8D622AA4'u64
  emitVector("random_i128_28", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0xCD41E4DDFF90499F'u64, 0xC6293B7ACC7199A2'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC07CCEB624299C73'u64
  doAssert raw.low == 0x32E995F0D910037E'u64
  emitVector("random_i128_29", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x8C49E1F27F0272C8'u64, 0x3C6E27E500B60C25'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407CE3713F2805B0'u64
  doAssert raw.low == 0x612C624F0F93F814'u64
  emitVector("random_i128_30", "Int128", converted)

block:
  let sourceValue = cast[Int128](makeUInt128(0x015A267AEE6C20CE'u64, 0x63C43E37A7AD9688'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x407D8F10F8DE9EB6'u64
  doAssert raw.low == 0x5A20056899EBB9B1'u64
  emitVector("random_i128_31", "Int128", converted)

block:
  let sourceValue = makeUInt256(0x29729BC717B3255A'u64, 0x0B033DD10C3F4CFD'u64, 0x38EC5BADF4237958'u64, 0xF04B1F4581D9602A'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FEE0963E8B03B2'u64
  doAssert raw.low == 0xC05471D8B75BE847'u64
  emitVector("random_u256_00", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0x529DCD345BD9A3BD'u64, 0x7A3829F022AB60B4'u64, 0x9BE97D3F07B02307'u64, 0x6D390F1692322D76'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FDB4E43C5A48C8'u64
  doAssert raw.low == 0xB5DA6FA5F4FC1EC1'u64
  emitVector("random_u256_01", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xB065BB84E0DBAF6B'u64, 0x0989D634DE77F007'u64, 0x0C65CD618D93F57A'u64, 0xD05A06F641131679'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FEA0B40DEC8226'u64
  doAssert raw.low == 0x2CF218CB9AC31B28'u64
  emitVector("random_u256_02", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xDCF7BEC84F955C62'u64, 0xBEDEE62475A769CE'u64, 0x453580154D1C70BB'u64, 0x20F5C1BD059A3731'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FC07AE0DE82CD1'u64
  doAssert raw.low == 0xB98A29AC00AA68E4'u64
  emitVector("random_u256_03", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xC58A053065B4946F'u64, 0x3AA9E448FA4EA94B'u64, 0xEAB8B483A9721F60'u64, 0xFDD6F9F7E5F9BF25'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FEFBADF3EFCBF3'u64
  doAssert raw.low == 0x7E4BD571690752E4'u64
  emitVector("random_u256_04", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0x65E30684FF0F3197'u64, 0xD8085688543E4895'u64, 0x1F606C03D07314D0'u64, 0x0497F5E39755F5D2'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40F925FD78E5D57D'u64
  doAssert raw.low == 0x7487D81B00F41CC5'u64
  emitVector("random_u256_05", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xBC8D7E04C115376E'u64, 0x0C56CED2FA65414D'u64, 0x422D4C12593924F3'u64, 0x9954A15C5182F9C9'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FE32A942B8A305'u64
  doAssert raw.low == 0xF392845A9824B272'u64
  emitVector("random_u256_06", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xE103712E4946669B'u64, 0x57C37363ED2DC925'u64, 0x48B61F54776587FC'u64, 0x5EC924C6317D049A'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FD7B249318C5F4'u64
  doAssert raw.low == 0x126922D87D51DD96'u64
  emitVector("random_u256_07", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0x66F0D12CBD0A55D6'u64, 0xA8F4F1DD0DC651EA'u64, 0x0DC5BD83A887C5CE'u64, 0x718B3F7DA10C4CCC'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FDC62CFDF68431'u64
  doAssert raw.low == 0x33303716F60EA21F'u64
  emitVector("random_u256_08", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0x9B01734E3C289E5C'u64, 0x08C3079F733324DF'u64, 0xBB4593A7E0F716B0'u64, 0xF4201D58A4930871'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FEE8403AB14926'u64
  doAssert raw.low == 0x10E3768B274FC1EE'u64
  emitVector("random_u256_09", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0x3F28817188F7D7AD'u64, 0x36BCCBF0D1D34820'u64, 0x49B8A3E4E13B2152'u64, 0x3CB9BDD30BC1F648'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FCE5CDEE985E0F'u64
  doAssert raw.low == 0xB2424DC51F2709D9'u64
  emitVector("random_u256_10", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xB4F58FF11B235824'u64, 0x85CC28D622565EB6'u64, 0x783636C75A565C43'u64, 0xE109935860D61EA3'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FEC21326B0C1AC'u64
  doAssert raw.low == 0x3D46F06C6D8EB4AD'u64
  emitVector("random_u256_11", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xEC5092A4085A1CC6'u64, 0xD640A43A4AE568E5'u64, 0x51A7A25BE752692D'u64, 0x1AE84F5562A478AE'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FBAE84F5562A47'u64
  doAssert raw.low == 0x8AE51A7A25BE7527'u64
  emitVector("random_u256_12", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xB01764EED01F7954'u64, 0x89D748D1E1249B40'u64, 0xED83F6744155E024'u64, 0xDC48B167893AADDB'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FEB89162CF1275'u64
  doAssert raw.low == 0x5BB7DB07ECE882AC'u64
  emitVector("random_u256_13", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0x98040730C057A36F'u64, 0x4DC732BAF6420AE5'u64, 0x29BBFC73F75CBC6E'u64, 0x3B869924A052600F'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FCDC34C9250293'u64
  doAssert raw.low == 0x00794DDFE39FBAE6'u64
  emitVector("random_u256_14", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0x26651254E4899DE0'u64, 0x9FD17A8F8F34E532'u64, 0x382054D5B0138A40'u64, 0xED75BC37728360C8'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FEDAEB786EE506'u64
  doAssert raw.low == 0xC1907040A9AB6027'u64
  emitVector("random_u256_15", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xB1D4DBC3D033941E'u64, 0x358CD8C4CD66CBB7'u64, 0x2FC957DBA3C91E7C'u64, 0x345601C8BA66CB9C'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FCA2B00E45D336'u64
  doAssert raw.low == 0x5CE17E4ABEDD1E49'u64
  emitVector("random_u256_16", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0x672A34775FC04AF6'u64, 0x0318B8BA968AF692'u64, 0x76B10074BCCCD498'u64, 0x5D0CA58E4375729E'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FD743296390DD5'u64
  doAssert raw.low == 0xCA79DAC401D2F333'u64
  emitVector("random_u256_17", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0x6F90CDB696AFFBA2'u64, 0x06E71B67622DA637'u64, 0xFD12E0E1FDA5EAC7'u64, 0x03B10CA49719972E'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40F8D886524B8CCB'u64
  doAssert raw.low == 0x977E897070FED2F5'u64
  emitVector("random_u256_18", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xA9B442C610573905'u64, 0xBDE055ADDF4773F7'u64, 0x99249E53A7502063'u64, 0x7BED67D35760D924'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FDEFB59F4D5D83'u64
  doAssert raw.low == 0x64926492794E9D41'u64
  emitVector("random_u256_19", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0x3923835EFCDEA35B'u64, 0x6268ECE42D5E056D'u64, 0x50A3483C95E628CF'u64, 0x6A4C57FF60E4639D'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FDA9315FFD8391'u64
  doAssert raw.low == 0x8E75428D20F25799'u64
  emitVector("random_u256_20", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0x1B2AF479E0808E30'u64, 0x95947AC59B5ED428'u64, 0x2E975852199F22B3'u64, 0xC80C766F403CDDF6'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FE9018ECDE8079'u64
  doAssert raw.low == 0xBBEC5D2EB0A4333E'u64
  emitVector("random_u256_21", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xF234032920DB5339'u64, 0xF9B176E295E0E799'u64, 0xB5355662EEC257F7'u64, 0xE15DB0180B28DB5F'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FEC2BB60301651'u64
  doAssert raw.low == 0xB6BF6A6AACC5DD85'u64
  emitVector("random_u256_22", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xB7CD1C35C7FAE7F1'u64, 0xC1EDC6FAAFB26D95'u64, 0xFF9E722817BA2805'u64, 0x2274E26404B9528D'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FC13A7132025CA'u64
  doAssert raw.low == 0x946FFCF39140BDD1'u64
  emitVector("random_u256_23", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xBE889C6F9D2A1B57'u64, 0x0B98FE00440655CA'u64, 0xB6E75008C62509BB'u64, 0xE79AD4ECDA4EAB94'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FECF35A9D9B49D'u64
  doAssert raw.low == 0x57296DCEA0118C4A'u64
  emitVector("random_u256_24", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0x574DA5B05463EE15'u64, 0x52365C916D0B713E'u64, 0xC53F9A39F23E3867'u64, 0xFF376EC75D8B15D2'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FEFE6EDD8EBB16'u64
  doAssert raw.low == 0x2BA58A7F3473E47C'u64
  emitVector("random_u256_25", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0x646966875D84CF68'u64, 0xB5E57C058808BE0D'u64, 0x112F4275DF9A59D7'u64, 0xD786172F68B4F983'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FEAF0C2E5ED169'u64
  doAssert raw.low == 0xF306225E84EBBF35'u64
  emitVector("random_u256_26", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0x25F603F8FF434C9C'u64, 0x0BE59992219A9146'u64, 0xF94270B9ED800712'u64, 0x02295C79C274F77F'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40F814AE3CE13A7B'u64
  doAssert raw.low == 0xBFFCA1385CF6C004'u64
  emitVector("random_u256_27", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xEC101A7EAAAEE0B1'u64, 0xE766140D6F558C19'u64, 0x6524957D4E614346'u64, 0xC850F482F31B8A68'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FE90A1E905E637'u64
  doAssert raw.low == 0x14D0CA492AFA9CC3'u64
  emitVector("random_u256_28", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0x56526509BD8B3994'u64, 0x7BC892D85B3DD433'u64, 0x509DF136D6E584A4'u64, 0xE7732DEF03F48E93'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FECEE65BDE07E9'u64
  doAssert raw.low == 0x1D26A13BE26DADCB'u64
  emitVector("random_u256_29", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0xDD86E5AB2807E73D'u64, 0x18B238DA242D9765'u64, 0xD7665396AC66D5DE'u64, 0x3164625BBC8E84F7'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FC8B2312DDE474'u64
  doAssert raw.low == 0x27BEBB329CB56337'u64
  emitVector("random_u256_30", "UInt256", converted)

block:
  let sourceValue = makeUInt256(0x48A9C8D2AEA4140E'u64, 0xFE9153DA6CC0E2B6'u64, 0xE0FC2E5F44366F2B'u64, 0x815FCAC0103FC39F'u64)
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FE02BF9580207F'u64
  doAssert raw.low == 0x873FC1F85CBE886D'u64
  emitVector("random_u256_31", "UInt256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x54F657AE8F32EC4E'u64, 0x2BE8863C0E869F72'u64, 0x64CE134F895F8E92'u64, 0xEC1071AA458C9A72'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0FB3EF8E55BA736'u64
  doAssert raw.low == 0x58D9B31ECB076A07'u64
  emitVector("random_i256_00", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0xFA3FB70FE6BF44BC'u64, 0x5FEA154DF5FED8C3'u64, 0xDA51B96B979E88F7'u64, 0x96B58968A36AE296'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0FDA529DA5D7254'u64
  doAssert raw.low == 0x75A496B91A51A186'u64
  emitVector("random_i256_01", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x5B82039A889446BB'u64, 0xA666876A6B3ABB9C'u64, 0xDFFA7A8D997F9A5B'u64, 0x90ABBBCB53956F91'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0FDBD5110D2B1AA'u64
  doAssert raw.low == 0x41B8801615C99A02'u64
  emitVector("random_i256_02", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0xE16CF50F4D3CA9DB'u64, 0x54198184F8E77BE8'u64, 0x7A1A564D99A33E0E'u64, 0x47BE4207D042F7DE'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FD1EF9081F410B'u64
  doAssert raw.low == 0xDF79E8695936668D'u64
  emitVector("random_i256_03", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0xAC5579FE3A5D941B'u64, 0x6804C486C74A576E'u64, 0xF3EB48D08EF0E6D8'u64, 0xB3659900F8C71B34'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0FD32699BFC1CE3'u64
  doAssert raw.low == 0x932C3052DCBDC43C'u64
  emitVector("random_i256_04", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0xE3FA79AA01E477D8'u64, 0x72AD8BEF3E845D50'u64, 0x649775358EFDC512'u64, 0xB896AAAE9408F79E'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0FD1DA55545AFDC'u64
  doAssert raw.low == 0x21866DA22B29C409'u64
  emitVector("random_i256_05", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0xC5527C067DD98817'u64, 0xE4C64BA801F3E311'u64, 0x04D5A8091253954C'u64, 0xF5FE3008425F6E81'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0FA4039FEF7B412'u64
  doAssert raw.low == 0x2FDF654AFEDDB58D'u64
  emitVector("random_i256_06", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x328E8786A39DA770'u64, 0x39E2FDF540F680A1'u64, 0xCC1C7315C1E49B00'u64, 0x3EB053CB11137C70'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FCF5829E58889B'u64
  doAssert raw.low == 0xE38660E398AE0F25'u64
  emitVector("random_i256_07", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x62E9D2A0DFF718AD'u64, 0xA6DB7E2D6E3A00B6'u64, 0xA78DF594F6E3A72A'u64, 0x8E7692A0A04C59D2'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0FDC625B57D7ECE'u64
  doAssert raw.low == 0x98B561C829AC2471'u64
  emitVector("random_i256_08", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x30C89E6AF364A548'u64, 0x9B88341E9BA216C3'u64, 0x324F8BF69436032A'u64, 0x026955F820CDFFA1'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40F834AAFC1066FF'u64
  doAssert raw.low == 0xD09927C5FB4A1B02'u64
  emitVector("random_i256_09", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x66597F62A7FA409D'u64, 0x19C8FE0D3773C331'u64, 0xAF64E8FCD1F26A71'u64, 0x70563F76E7395A40'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FDC158FDDB9CE5'u64
  doAssert raw.low == 0x6902BD93A3F347CA'u64
  emitVector("random_i256_10", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x33A1EF5F981A2DF5'u64, 0xEDDFB201B0F90CFE'u64, 0xCFC521F579EDB6A2'u64, 0x39B0FC85A95EAB1E'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FCCD87E42D4AF5'u64
  doAssert raw.low == 0x58F67E290FABCF6E'u64
  emitVector("random_i256_11", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0xD268FC4A1704C712'u64, 0x2AEA5154B74D94E3'u64, 0x2793277E22B00B6F'u64, 0x1E769CBAA1F4AB12'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FBE769CBAA1F4A'u64
  doAssert raw.low == 0xB122793277E22B01'u64
  emitVector("random_i256_12", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0xD43EDF2CF4AF7070'u64, 0xF40528E6889FBE6D'u64, 0x46E3768B3759E3FC'u64, 0xFA0793AC3E10995B'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0F97E1B14F07BD9'u64
  doAssert raw.low == 0xA92E47225D322987'u64
  emitVector("random_i256_13", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0xDFB47AB7202127CE'u64, 0x6351F5AC66509AC7'u64, 0x45CE3B508389AB6B'u64, 0xF17ED97D9A4A929D'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0FAD024D04CB6AD'u64
  doAssert raw.low == 0xAC57463895EF8ECB'u64
  emitVector("random_i256_14", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x4BB116D8894031A3'u64, 0xCA862FAEE742E9F2'u64, 0x2F60BA9FB29C0C15'u64, 0x146C61F02BCA4468'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FB46C61F02BCA4'u64
  doAssert raw.low == 0x4682F60BA9FB29C1'u64
  emitVector("random_i256_15", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x4C1D8BA528704671'u64, 0x6BD9EF31ADD291BB'u64, 0x0C0E403E1EC56A2B'u64, 0x6A237F3BCA557088'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FDA88DFCEF2955'u64
  doAssert raw.low == 0xC220303900F87B16'u64
  emitVector("random_i256_16", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x5AE57AA92DE75CCA'u64, 0x2585BEAD11D988A8'u64, 0xAD634D941D6CB34E'u64, 0x3F965B0978B87AA9'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FCFCB2D84BC5C3'u64
  doAssert raw.low == 0xD54D6B1A6CA0EB66'u64
  emitVector("random_i256_17", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x46C4CC1E8919195F'u64, 0x558F98752807029A'u64, 0xF7CF17B9AD3B78CC'u64, 0xA84CAF5F46D0281B'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0FD5ECD4282E4BF'u64
  doAssert raw.low == 0x5F9020C3A1194B12'u64
  emitVector("random_i256_18", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x8B0461DB5A1D767F'u64, 0x4DBA4CD6CE8BA0D8'u64, 0x27CD9C94F7C74715'u64, 0xC168DF794D5D55C2'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0FCF4B904359515'u64
  doAssert raw.low == 0x51EEC1931B5841C6'u64
  emitVector("random_i256_19", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0xCD420C43AF0AD456'u64, 0xB56C6D89A4A4E63B'u64, 0x067FBD394F36C293'u64, 0x79B85B31DCFC0BB9'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FDE6E16CC773F0'u64
  doAssert raw.low == 0x2EE419FEF4E53CDB'u64
  emitVector("random_i256_20", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x076D6D5AFB267821'u64, 0xE59865E34A65FC44'u64, 0x1AC5FCDC90EECA45'u64, 0x055F3C61287F778B'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40F957CF184A1FDD'u64
  doAssert raw.low == 0xE2C6B17F37243BB3'u64
  emitVector("random_i256_21", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x069595EEB98C65EB'u64, 0x5DF0D9462B75EAD0'u64, 0x366046BA09F7C7D9'u64, 0x04DB1389C60F780F'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40F936C4E27183DE'u64
  doAssert raw.low == 0x03CD9811AE827DF2'u64
  emitVector("random_i256_22", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x80754B5CE64B67B2'u64, 0xEEAD1020256C6545'u64, 0x1A0A3ECA16C9F3DF'u64, 0xEBB8F538B67B1053'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0FB4470AC74984E'u64
  doAssert raw.low == 0xFACE5F5C135E9361'u64
  emitVector("random_i256_23", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x4F4D37D93D253659'u64, 0x99AECA95122126FE'u64, 0xAD63026AA8F50AC9'u64, 0xA7CE335F181B5BF4'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0FD60C732839F92'u64
  doAssert raw.low == 0x902D4A73F6555C2C'u64
  emitVector("random_i256_24", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0xA91E1FC09C22CC44'u64, 0x49EBA8DD6238872C'u64, 0xA963111580DCF06A'u64, 0x8185F633F49310E7'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0FDF9E827302DB3'u64
  doAssert raw.low == 0xBC615A73BBA9FC8C'u64
  emitVector("random_i256_25", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x0BA57C72829C7047'u64, 0xA7DA8E72893483C0'u64, 0xD8BFB4F20D9FD104'u64, 0x61BA18A9085DFFFD'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FD86E862A42177'u64
  doAssert raw.low == 0xFFF762FED3C8367F'u64
  emitVector("random_i256_26", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0xFC4C581A31E46220'u64, 0x01B1D15595643037'u64, 0x404C3830AD778DB3'u64, 0xFC09F383415A45A6'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0F8FB063E5F52DD'u64
  doAssert raw.low == 0x2CDFD9E3E7A94439'u64
  emitVector("random_i256_27", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x890D9E3CC149BDB3'u64, 0xB8F60A4988B55875'u64, 0xAD91EA4768927776'u64, 0x7599564776ED044F'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FDD665591DDBB4'u64
  doAssert raw.low == 0x113EB647A91DA24A'u64
  emitVector("random_i256_28", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x2692EE66A3E6C5F4'u64, 0x7A8BF88C287A7EA2'u64, 0x615DB0905651E9F4'u64, 0x87CD638154CB07A4'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0FDE0CA71FAACD3'u64
  doAssert raw.low == 0xE16E7A893DBEA6B8'u64
  emitVector("random_i256_29", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0xBF6D1C9644257B19'u64, 0xB609E5FA15080337'u64, 0xAA16B875D2FC776E'u64, 0x15A91FB60EEEA9E9'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0x40FB5A91FB60EEEA'u64
  doAssert raw.low == 0x9E9AA16B875D2FC7'u64
  emitVector("random_i256_30", "Int256", converted)

block:
  let sourceValue = cast[Int256](makeUInt256(0x6FF281EC3E909795'u64, 0xF6487492A5BB1C83'u64, 0x121D50ACEB74A72D'u64, 0xD963A78DB6CD94B1'u64))
  let converted = toFloat128(sourceValue)
  let raw = toBits(converted)
  doAssert raw.high == 0xC0FC34E2C3924993'u64
  doAssert raw.low == 0x5A776F157A98A45B'u64
  emitVector("random_i256_31", "Int256", converted)

echo "INTCONV.VECTOR_COUNT=157"
echo "INTCONV.VECTORS=PASS"
echo "INTCONV.UNSIGNED=PASS"
echo "INTCONV.SIGNED=PASS"
echo "INTCONV.ROUND_TIES_TO_EVEN=PASS"
echo "FLOAT128_INTEGER_CONVERSION_OK"

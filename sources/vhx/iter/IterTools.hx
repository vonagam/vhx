package vhx.iter;

import vhx.funcs.Supplier;

import vhx.iter.Iter;


class IterTools {

  public static inline function iter< T >( that: Iterable< T > ): Iter< T >

    return that;


  public static inline function iterEntries< K, V >( that: KeyValueIterable< K, V > ): EntryIter< K, V >

    return new vhx.iter.impl.KeyValuesIterable( that );

  public static inline function iterKeys< K, V >( that: KeyValueIterable< K, V > ): Iter< K >

    return new vhx.iter.impl.KeysIterable( that );

  public static inline function iterValues< K, V >( that: KeyValueIterable< K, V > ): Iter< V >

    return new vhx.iter.impl.ValuesIterable( that );


  public static inline function iterIterator< T >( that: Iterator< T > ): Iter< T >

    return { iterator: () -> that };


  public static inline function iterReverse< T >( array: Array< T > ): Iter< T >

    return new vhx.iter.impl.ReverseIterable( array );

  public static inline function iterRepeat< T >( value: T ): Iter< T >

    return new vhx.iter.impl.RepeatIterable( value );

  public static inline function iterRange< T >( start: Int, end: Int ): Iter< Int >

    return new vhx.iter.impl.RangeIterable( start, end );

  public static inline function iterSupply< T >( supplier: Supplier< T > ): Iter< T >

    return new vhx.iter.impl.SupplyIterable( supplier );


  public static inline function iterNext< T >( value: T, next: ( value: T ) -> T ): Iter< T >

    return new vhx.iter.impl.NextIterable( value, next );

}

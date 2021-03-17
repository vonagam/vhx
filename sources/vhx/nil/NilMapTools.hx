package vhx.nil;


class NilMapTools {

  public static inline function isEmpty< K, V >( that: Nil< Map< K, V > > )

    return that.turn( _ -> ! _.iterator().hasNext(), true );


  public static inline function clear< K, V >( that: Nil< Map< K, V > > )

    that.ifSet( _ -> _.clear() );

  public static inline function copy< K, V >( that: Nil< Map< K, V > > )

    return that.map( _ -> _.copy() );

  public static inline function exists< K, V >( that: Nil< Map< K, V > >, key: K )

    return that.turn( _ -> _.exists( key ), false );

  public static inline function get< K, V >( that: Nil< Map< K, V > >, key: K )

    return that.map( _ -> _.get( key ) );

  public static inline function iterator< K, V >( that: Nil< Map< K, V > > )

    return that.turn( _ -> _.iterator(), () -> new vhx.iter.Empty.EmptyIterator() );

  public static inline function keys< K, V >( that: Nil< Map< K, V > > )

    return that.turn( _ -> _.keys(), () -> new vhx.iter.Empty.EmptyIterator() );

  public static inline function keyValueIterator< K, V >( that: Nil< Map< K, V > > )

    return that.turn( _ -> _.keyValueIterator(), () -> new vhx.iter.Empty.EmptyIterator() );

  public static inline function remove< K, V >( that: Nil< Map< K, V > >, key: K )

    return that.turn( _ -> _.remove( key ), false );

  public static inline function toString< K, V >( that: Nil< Map< K, V > > )

    return that.map( _ -> _.toString() );

}

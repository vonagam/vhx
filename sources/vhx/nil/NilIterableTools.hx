package vhx.nil;


class NilIterableTools {

  public static inline function iterator< T >( that: Nil< Iterable< T > > )

    return that.turn( _ -> _.iterator(), () -> new vhx.iter.Empty.EmptyIterator() );

  public static inline function isEmpty< T >( that: Nil< Iterable< T > > )

    return that.turn( _ -> _.iterator().hasNext(), false );

}

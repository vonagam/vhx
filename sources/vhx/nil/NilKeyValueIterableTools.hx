package vhx.nil;


class NilKeyValueIterableTools {

  public static inline function keyValueIterator< K, V >( that: Nil< KeyValueIterable< K, V > > )

    return that.turn( _ -> _.keyValueIterator(), () -> new vhx.iter.Empty.EmptyIterator() );

  public static inline function isEmpty< K, V >( that: Nil< KeyValueIterable< K, V > > )

    return that.turn( _ -> _.keyValueIterator().hasNext(), false );

}

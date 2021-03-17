package vhx.iter.impl;


class KeyValuesIterable< K, V > {

  final iterable: KeyValueIterable< K, V >;


  public inline function new( iterable: KeyValueIterable< K, V > )

    this.iterable = iterable;


  public inline function iterator()

    return this.iterable.keyValueIterator();

}

package vhx.iter.impl;


class KeysIterable< K, V > {

  final iterable: KeyValueIterable< K, V >;


  public inline function new( iterable: KeyValueIterable< K, V > )

    this.iterable = iterable;


  public inline function iterator()

    return new KeysIterator( this.iterable.keyValueIterator() );

}


class KeysIterator< K, V > {

  final iterator: KeyValueIterator< K, V >;


  public inline function new( iterator: KeyValueIterator< K, V > ) {

    this.iterator = iterator;

  }


  public inline function hasNext()

    return iterator.hasNext();

  public inline function next()

    return iterator.next().key;

}

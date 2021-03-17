package vhx.iter;

import vhx.iter.Entry;


class EmptyIterable< T > {

  public inline function new() {}


  public inline function iterator()

    return new EmptyIterator< T >();

}


class EmptyKeyValueIterable< K, V > {

  public inline function new() {}


  public inline function keyValueIterator()

    return new EmptyIterator< Entry< K, V > >();

}


class EmptyIterator< T > {

  public inline function new() {}


  public inline function hasNext()

    return false;

  public inline function next(): T

    throw 'Cannot call next() on EmptyIterator.';

}

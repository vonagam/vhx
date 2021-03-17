package vhx.iter.impl;

import vhx.funcs.Supplier;


class ScanIterable< S, A, T > {

  final iterable: Iterable< S >;

  final accumulator: Supplier< A >;

  final scan: ( accumulator: { value: A }, value: S ) -> T;


  public inline function new( iterable: Iterable< S >, accumulator: Supplier< A >, scan: ( accumulator: { value: A }, value: S ) -> T ) {

    this.iterable = iterable;

    this.accumulator = accumulator;

    this.scan = scan;

  }


  public inline function iterator()

    return new ScanIterator( iterable.iterator(), accumulator(), scan );

}


class ScanIterator< S, A, T > {

  final iterator: Iterator< S >;

  final accumulator: { value: A };

  final scan: ( accumulator: { value: A }, value: S ) -> T;


  public inline function new( iterator: Iterator< S >, accumulator: A, scan: ( accumulator: { value: A }, value: S ) -> T ) {

    this.iterator = iterator;

    this.accumulator = { value: accumulator };

    this.scan = scan;

  }


  public inline function hasNext()

    return iterator.hasNext();

  public inline function next()

    return scan( accumulator, iterator.next() );

}

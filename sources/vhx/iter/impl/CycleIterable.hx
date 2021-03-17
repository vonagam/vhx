package vhx.iter.impl;


class CycleIterable< T > {

  final iterable: Iterable< T >;


  public inline function new( iterable: Iterable< T >) {

    this.iterable = iterable;

  }


  public inline function iterator()

    return new CycleIterator( iterable.iterator() );

}


class CycleIterator< T > {

  var iterator: Iterator< T >;

  final values = new Array< T >();

  var recycling = false;


  public function new( iterator: Iterator< T > ) {

    this.iterator = iterator;

  }


  public function hasNext() {

    if ( ! recycling ) {

      if ( iterator.hasNext() ) return true;

      recycling = true;

      iterator = values.iterator();

    }

    return values.length != 0;

  }

  public function next() {

    if ( ! recycling ) {

      final value = iterator.next();

      values.push( value );

      return value;

    }

    if ( ! iterator.hasNext() ) iterator = values.iterator();

    return iterator.next();

  }

}

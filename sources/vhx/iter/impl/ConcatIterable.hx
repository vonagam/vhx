package vhx.iter.impl;

import vhx.iter.Empty.EmptyIterator;


class ConcatIterable< T > {

  final iterables: Iterable< Iterable< T > >;


  public inline function new( iterables: Iterable< Iterable< T > > )

    this.iterables = iterables;


  public inline function iterator()

    return new ConcatIterator( this.iterables.iterator() );

}


class ConcatIterator< T > {

  final iterables: Iterator< Iterable< T > >;

  var iterator: Iterator< T >;


  public function new( iterables: Iterator< Iterable< T > > ) { // TODO: shouldn't be Iterator< Iterator< T > > ?

    this.iterables = iterables;

    this.iterator = iterables.hasNext() ? iterables.next().iterator() : new EmptyIterator< T >();

  }


  public function hasNext() {

    while ( ! iterator.hasNext() ) {

      if ( ! iterables.hasNext() ) return false;

      iterator = iterables.next().iterator();

    }

    return true;

  }

  public function next()

    return iterator.next();

}

package vhx.iter.impl;

import vhx.funcs.Predicate;

import vhx.iter.SimpleIterator;


class SkipWhileIterable< T > {

  final iterable: Iterable< T >;

  final predicate: Predicate< T >;


  public inline function new( iterable: Iterable< T >, predicate: Predicate< T > ) {

    this.iterable = iterable;

    this.predicate = predicate;

  }


  public inline function iterator()

    return new SkipWhileIterator( iterable.iterator(), predicate );

}


class SkipWhileIterator< T > extends SimpleIterator< T > {

  final iterator: Iterator< T >;

  final predicate: Predicate< T >;

  var skipped = false;


  public function new( iterator: Iterator< T >, predicate: Predicate< T > ) {

    this.iterator = iterator;

    this.predicate = predicate;

  }


  function step() {

    if ( ! skipped ) {

      do {

        has = iterator.hasNext();

        if ( ! has ) return;

        value = iterator.next();

      } while ( predicate( value ) );

      skipped = true;

    } else {

      has = iterator.hasNext();

      if ( has ) value = iterator.next();

    }

  }

}

package vhx.nil;

import vhx.funcs.Comparer;

import vhx.funcs.Mapper;

import vhx.funcs.Predicate;


class NilArrayTools {

  public static inline function orEmpty< T >( that: Nil< Array< T > > )

    return that.or( () -> new Array< T >() );

  public static inline function isEmpty< T >( that: Nil< Array< T > > )

    return that.turn( _ -> _.length == 0, true );


  public static inline function concat< T >( that: Nil< Array< T > >, array: Array< T > )

    return that.turn( _ -> _.concat( array ), () -> [] );

  public static inline function contains< T >( that: Nil< Array< T > >, value: T )

    return that.turn( _ -> _.contains( value ), false );

  public static inline function copy< T >( that: Nil< Array< T > > )

    return that.map( _ -> _.copy() );

  public static inline function filter< T >( that: Nil< Array< T > >, filter: Predicate< T > )

    return that.map( _ -> _.filter( filter ) );

  public static inline function indexOf< T >( that: Nil< Array< T > >, value: T, ?fromIndex: Int )

    return that.turn( _ -> _.indexOf( value, fromIndex ), -1 );

  public static inline function iterator< T >( that: Nil< Array< T > > )

    return that.turn( _ -> ( _.iterator(): Iterator< T > ), () -> new vhx.iter.Empty.EmptyIterator() );

  public static inline function join< T >( that: Nil< Array< T > >, separator: String )

    return that.turn( _ -> _.join( separator ), '' );

  public static inline function keyValueIterator< T >( that: Nil< Array< T > > )

    return that.turn( _ -> ( _.keyValueIterator(): KeyValueIterator< Int, T > ), () -> new vhx.iter.Empty.EmptyIterator() );

  public static inline function lastIndexOf< T >( that: Nil< Array< T > >, value: T, ?fromIndex: Int )

    return that.turn( _ -> _.lastIndexOf( value, fromIndex ), -1 );

  public static inline function map< T, S >( that: Nil< Array< T > >, map: Mapper< T, S > )

    return that.map( _ -> _.map( map ) );

  public static inline function pop< T >( that: Nil< Array< T > > )

    return that.map( _ -> _.pop() );

  public static inline function remove< T >( that: Nil< Array< T > >, value: T )

    return that.turn( _ -> _.remove( value ), false );

  public static inline function resize< T >( that: Nil< Array< T > >, length: Int )

    that.ifSet( _ -> _.resize( length ) );

  public static inline function reverse< T >( that: Nil< Array< T > > )

    that.ifSet( _ -> _.reverse() );

  public static inline function slice< T >( that: Nil< Array< T > >, position: Int, ?end: Int )

    return that.map( _ -> _.slice( position, end ) );

  public static inline function sort< T >( that: Nil< Array< T > >, compare: Comparer< T > )

    that.ifSet( _ -> _.sort( compare ) );

  public static inline function splice< T >( that: Nil< Array< T > >, position: Int, length: Int )

    return that.map( _ -> _.splice( position, length ) );

  public static inline function toString< T >( that: Nil< Array< T > > )

    return that.map( _ -> _.toString() );


  public static inline function length< T >( that: Nil< Array< T > > )

    return that.turn( _ -> _.length, 0 );

}

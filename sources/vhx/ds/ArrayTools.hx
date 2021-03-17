package vhx.ds;

import vhx.funcs.Predicate;

import vhx.funcs.Supplier;


class ArrayTools {

  public static inline function isEmpty< T >( array: Array< T > )

    return array.length == 0;

  public static inline function first< T >( array: Array< T > )

    return array[ 0 ];

  public static inline function last< T >( array: Array< T > )

    return array[ array.length - 1 ];

  public static inline function sample< T >( array: Array< T > )

    return array[ Std.random( array.length ) ];

  public static inline function includes< T >( array: Array< T >, predicate: Predicate< T >, ?fromIndex: Int )

    return findIndexOf( array, predicate, fromIndex ) != -1;


  public static function append< T >( array: Array< T >, values: Array< T > ) {

    for ( value in values ) array.push( value );

  }

  public static function prepend< T >( array: Array< T >, values: Array< T > ) {

    var index = values.length;

    while ( --index >= 0 ) array.unshift( values[ index ] );

  }


  public static function findIndexOf< T >( array: Array< T >, predicate: Predicate< T >, ?fromIndex: Int ) {

    final length = array.length;

    if ( fromIndex == null ) fromIndex = 0;

    if ( fromIndex < 0 ) fromIndex = length + fromIndex;

    if ( fromIndex < 0 ) fromIndex = 0;

    while ( fromIndex < length ) if ( predicate( array[ fromIndex++ ] ) ) return fromIndex - 1;

    return -1;

  }

  public static function findLastIndexOf< T >( array: Array< T >, predicate: Predicate< T >, ?fromIndex: Int ) {

    final length = array.length;

    if ( fromIndex == null ) fromIndex = length - 1;

    if ( fromIndex < 0 ) fromIndex = length + fromIndex;

    if ( fromIndex >= length ) fromIndex = length - 1;

    while ( fromIndex > -1 ) if ( predicate( array[ fromIndex-- ] ) ) return fromIndex + 1;

    return -1;

  }


  public static function removeIf< T >( array: Array< T >, predicate: Predicate< T > ) {

    var index = array.length;

    while ( index-- > 0 ) if ( predicate( array[ index ] ) ) array.splice( index, 1 );

  }


  public static function findOrPush< T >( array: Array< T >, predicate: Predicate< T >, value: Supplier< T > ) {

    for ( item in array ) if ( predicate( item ) ) return item;

    final result = value();

    array.push( result );

    return result;

  }

}

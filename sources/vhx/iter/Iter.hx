package vhx.iter;

import haxe.ds.List;

import vhx.funcs.Comparer;

import vhx.funcs.Consumer;

import vhx.funcs.Mapper;

import vhx.funcs.Predicate;

import vhx.funcs.Supplier;

using vhx.ds.MapTools;


typedef EntryIter< K, V > = Iter< Entry< K, V > >;


@:forward( iterator ) @:transitive

@:using( vhx.iter.Iter )

@:using( vhx.iter.Iter.IterIntTools )

@:using( vhx.iter.Iter.IterFloatTools )

@:using( vhx.iter.Iter.IterStringTools )

abstract Iter< T >( Iterable< T > ) from Iterable< T > to Iterable< T > {

  public static inline function append< T >( that: Iter< T >, value: T ): Iter< T >

    return new vhx.iter.impl.ConcatIterable( [ [ value ], that ] );

  public static inline function chain< T >( that: Iter< T >, next: Iter< T > ): Iter< T >

    return new vhx.iter.impl.ConcatIterable( [ that, next ] );

  public static inline function cycle< T >( that: Iter< T > ): Iter< T >

    return new vhx.iter.impl.CycleIterable( that );

  public static inline function difference< T >( that: Iter< T >, other: Iter< T > ): Iter< T >

    return new vhx.iter.impl.DifferenceIterable( that, other );

  public static inline function enumerate< T >( that: Iter< T > ): EntryIter< Int, T >

    return new vhx.iter.impl.EnumerateIterable( that );

  public static inline function filter< T >( that: Iter< T >, predicate: Predicate< T > ): Iter< T >

    return new vhx.iter.impl.FilterIterable( that, predicate );

  public static inline function flatten< T >( that: Iter< Iter< T > > ): Iter< T >

    return new vhx.iter.impl.ConcatIterable( that );

  public static inline function inspect< T >( that: Iter< T >, consume: Consumer< T > ): Iter< T >

    return new vhx.iter.impl.InspectIterable( that, consume );

  public static inline function intersect< T >( that: Iter< T >, other: Iter< T > ): Iter< T >

    return new vhx.iter.impl.IntersectIterable( that, other );

  public static inline function map< S, T >( that: Iter< S >, map: Mapper< S, T > ): Iter< T >

    return new vhx.iter.impl.MapIterable( that, map );

  public static inline function prepend< T >( that: Iter< T >, value: T ): Iter< T >

    return new vhx.iter.impl.ConcatIterable( [ that, [ value ] ] );

  public static inline function reject< T >( that: Iter< T >, predicate: Predicate< T > ): Iter< T >

    return new vhx.iter.impl.FilterIterable( that, predicate.negate() );

  public static inline function scan< S, A, T >( that: Iter< S >, accumulator: Supplier< A >, scan: ( accumulator: { value: A }, value: S ) -> T ): Iter< T >

    return new vhx.iter.impl.ScanIterable( that, accumulator, scan );

  public static inline function skip< T >( that: Iter< T >, length: Int ): Iter< T >

    return new vhx.iter.impl.SkipIterable( that, length );

  public static inline function skipUntil< T >( that: Iter< T >, predicate: Predicate< T > ): Iter< T >

    return new vhx.iter.impl.SkipWhileIterable( that, predicate.negate() );

  public static inline function skipWhile< T >( that: Iter< T >, predicate: Predicate< T > ): Iter< T >

    return new vhx.iter.impl.SkipWhileIterable( that, predicate );

  public static inline function stepBy< T >( that: Iter< T >, length: Int ): Iter< T >

    return new vhx.iter.impl.StepByIterable( that, length );

  public static inline function take< T >( that: Iter< T >, length: Int ): Iter< T >

    return new vhx.iter.impl.TakeIterable( that, length );

  public static inline function takeUntil< T >( that: Iter< T >, predicate: Predicate< T > ): Iter< T >

    return new vhx.iter.impl.TakeWhileIterable( that, predicate.negate() );

  public static inline function takeWhile< T >( that: Iter< T >, predicate: Predicate< T > ): Iter< T >

    return new vhx.iter.impl.TakeWhileIterable( that, predicate );

  public static inline function unique< T >( that: Iter< T > ): Iter< T >

    return new vhx.iter.impl.UniqueIterable( that );

  public static inline function zip< K, V >( that: Iter< K >, other: Iter< V > ): EntryIter< K, V >

    return new vhx.iter.impl.ZipIterable( that, other );


  public static inline function keys< K, V >( that: EntryIter< K, V > ): Iter< K >

    return new vhx.iter.impl.MapIterable( that, ( entry ) -> entry.key );

  public static inline function values< K, V >( that: EntryIter< K, V > ): Iter< V >

    return new vhx.iter.impl.MapIterable( that, ( entry ) -> entry.value );

  public static inline function key< K, V >( that: Iter< V >, key: Mapper< V, K > ): EntryIter< K, V >

    return new vhx.iter.impl.MapIterable( that, ( value ) -> { key: key( value ), value: value } );

  public static inline function value< K, V >( that: Iter< K >, value: Mapper< K, V > ): EntryIter< K, V >

    return new vhx.iter.impl.MapIterable( that, ( key ) -> { key: key, value: value( key ) } );

  public static inline function rekey< SK, RK, V >( that: EntryIter< SK, V >, key: Mapper< Entry< SK, V >, RK > ): EntryIter< RK, V >

    return new vhx.iter.impl.MapIterable( that, ( entry ) -> { key: key( entry ), value: entry.value } );

  public static inline function revalue< K, SV, RV >( that: EntryIter< K, SV >, value: Mapper< Entry< K, SV >, RV > ): EntryIter< K, RV >

    return new vhx.iter.impl.MapIterable( that, ( entry ) -> { key: entry.key, value: value( entry ) } );

  public static inline function flip< K, V >( that: EntryIter< K, V > ): EntryIter< V, K >

    return new vhx.iter.impl.MapIterable( that, ( entry ) -> { key: entry.value, value: entry.key } );


  public static inline function forEach< T >( that: Iter< T >, consume: Consumer< T > )

    for ( value in that ) consume( value );


  public static function all< T >( that: Iter< T >, predicate: Predicate< T > ) {

    for ( value in that ) if ( ! predicate( value ) ) return false;

    return true;

  }

  public static function any< T >( that: Iter< T >, predicate: Predicate< T > ) {

    for ( value in that ) if ( predicate( value ) ) return true;

    return false;

  }

  public static inline function none< T >( that: Iter< T >, predicate: Predicate< T > )

    return ! that.any( predicate );


  public static inline function isEmpty< T >( that: Iter< T > )

    return that.iterator().hasNext();


  public static function contains< T >( that: Iter< T >, value: T ) {

    for ( element in that ) if ( element == value ) return true;

    return false;

  }


  public static function first< T >( that: Iter< T > ): Nil< T > {

    for ( value in that ) return value;

    return null;

  }

  public static function last< T >( that: Iter< T > ): Nil< T > {

    var result: Null< T > = null;

    for ( value in that ) result = value;

    return result;

  }

  public static function nth< T >( that: Iter< T >, index: Int ): Nil< T > {

    var result: Null< T > = null;

    for ( value in that ) if ( index-- == 0 ) result = value;

    return result;

  }


  public static function find< T >( that: Iter< T >, predicate: Predicate< T > ): Nil< T > {

    for ( value in that ) if ( predicate( value ) ) return value;

    return null;

  }

  public static function findLast< T >( that: Iter< T >, predicate: Predicate< T > ): Nil< T > {

    var result: Null< T > = null;

    for ( value in that ) if ( predicate( value ) ) result = value;

    return result;

  }

  public static function findIndex< T >( that: Iter< T >, predicate: Predicate< T > ): Int {

    var index = 0;

    for ( value in that ) { index++; if ( predicate( value ) ) return index; }

    return -1;

  }

  public static function findLastIndex< T >( that: Iter< T >, predicate: Predicate< T > ): Int {

    var index = 0;

    var result = -1;

    for ( value in that ) { index++; if ( predicate( value ) ) result = index; }

    return result;

  }

  public static function count< T >( that: Iter< T > ) {

    var counter = 0;

    for ( value in that ) ++counter;

    return counter;

  }

  public static function fold< T, R >( that: Iter< T >, accumulator: R, map: ( accumulator: R, value: T ) -> R ) {

    for ( value in that ) accumulator = map( accumulator, value );

    return accumulator;

  }

  public static function reduce< T >( that: Iter< T >, map: ( accumulator: T, value: T ) -> T ): Nil< T > {

    final iterator = that.iterator();

    if ( ! iterator.hasNext() ) return null;

    var accumulator = iterator.next();

    while ( iterator.hasNext() ) accumulator = map( accumulator, iterator.next() );

    return accumulator;

  }

  public static function unzip< K, V >( that: EntryIter< K, V > ): Entry< Array< K >, Array< V > > {

    final first = new Array< K >();

    final second = new Array< V >();

    for ( entry in that ) {

      first.push( entry.first );

      second.push( entry.second );

    }

    return new Entry( first, second );

  }

  public static function partition< T >( that: Iter< T >, predicate: Predicate< T > ): Entry< Array< T >, Array< T > > {

    final first = new Array< T >();

    final second = new Array< T >();

    for ( entry in that ) {

      ( predicate( entry ) ? first : second ).push( entry );

    }

    return new Entry( first, second );

  }


  public static function maxBy< T >( that: Iter< T >, compare: Comparer< T >, last: Bool = false ) {

    return that.reduce( ( accumulator, value ) -> {

      final check = compare( accumulator, value );

      return check == 0 ? ( last ? value : accumulator ) : check > 0 ? accumulator : value;

    } );

  }

  public static function minBy< T >( that: Iter< T >, compare: Comparer< T >, last: Bool = false ) {

    return that.reduce( ( accumulator, value ) -> {

      final check = compare( accumulator, value );

      return check == 0 ? ( last ? value : accumulator ) : check < 0 ? accumulator : value;

    } );

  }

  public static function maxKeyedBy< K, V >( that: EntryIter< K, V >, compare: Comparer< K >, last: Bool = false )

    return that.maxBy( ( accumulator, value ) -> compare( accumulator.key, value.key ), last );

  public static function minKeyedBy< K, V >( that: EntryIter< K, V >, compare: Comparer< K >, last: Bool = false )

    return that.minBy( ( accumulator, value ) -> compare( accumulator.key, value.key ), last );

  public static function maxValuedBy< K, V >( that: EntryIter< K, V >, compare: Comparer< V >, last: Bool = false )

    return that.maxBy( ( accumulator, value ) -> compare( accumulator.value, value.value ), last );

  public static function minValuedBy< K, V >( that: EntryIter< K, V >, compare: Comparer< V >, last: Bool = false )

    return that.minBy( ( accumulator, value ) -> compare( accumulator.value, value.value ), last );


  public static function toArray< T >( that: Iter< T > ) {

    final array = new Array< T >();

    for ( value in that ) array.push( value );

    return array;

  }

  public static function toList< T >( that: Iter< T > ) {

    final list = new List< T >();

    for ( value in that ) list.add( value );

    return list;

  }


  public static function toMapInto< K, V >( that: EntryIter< K, V >, map: Map< K, V > ) {

    for ( entry in that ) map.set( entry.key, entry.value );

    return map;

  }

  public static inline function toStringMap< K: String, V >( that: EntryIter< K, V > )

    return toMapInto( that, new Map< K, V >() );

  public static inline function toIntMap< K: Int, V >( that: EntryIter< K, V > )

    return toMapInto( that, new Map< K, V >() );

  public static inline function toEnumMap< K: EnumValue, V >( that: EntryIter< K, V > )

    return toMapInto( that, new Map< K, V >() );

  public static inline function toObjectMap< K: {}, V >( that: EntryIter< K, V > )

    return toMapInto( that, new Map< K, V >() );

  public static inline extern overload function toMap< K: String, V >( that: EntryIter< K, V > )

    return toStringMap( that );

  public static inline extern overload function toMap< K: Int, V >( that: EntryIter< K, V > )

    return toIntMap( that );

  public static inline extern overload function toMap< K: EnumValue, V >( that: EntryIter< K, V > )

    return toEnumMap( that );

  public static inline extern overload function toMap< K: {}, V >( that: EntryIter< K, V > )

    return toObjectMap( that );


  public static function toGroupsInto< K, V >( that: EntryIter< K, V >, map: Map< K, Array< V > > ) {

    for ( entry in that ) map.getOrSet( entry.key, [] ).push( entry.value );

    return map;

  }

  public static inline function toStringGroups< K: String, V >( that: EntryIter< K, V > )

    return toGroupsInto( that, new Map< K, Array< V > >() );

  public static inline function toIntGroups< K: Int, V >( that: EntryIter< K, V > )

    return toGroupsInto( that, new Map< K, Array< V > >() );

  public static inline function toEnumGroups< K: EnumValue, V >( that: EntryIter< K, V > )

    return toGroupsInto( that, new Map< K, Array< V > >() );

  public static inline function toObjectGroups< K: {}, V >( that: EntryIter< K, V > )

    return toGroupsInto( that, new Map< K, Array< V > >() );

  public static inline extern overload function toGroups< K: String, V >( that: EntryIter< K, V > )

    return toStringGroups( that );

  public static inline extern overload function toGroups< K: Int, V >( that: EntryIter< K, V > )

    return toIntGroups( that );

  public static inline extern overload function toGroups< K: EnumValue, V >( that: EntryIter< K, V > )

    return toEnumGroups( that );

  public static inline extern overload function toGroups< K: {}, V >( that: EntryIter< K, V > )

    return toObjectGroups( that );

}


class IterIntTools {

  public static function max( that: Iter< Int > )

    return that.reduce( ( max, value ) -> value > max ? value : max );

  public static function min( that: Iter< Int > )

    return that.reduce( ( min, value ) -> value < min ? value : min );

  public static function product( that: Iter< Int > )

    return that.reduce( ( product, value ) -> product * value );

  public static function sum( that: Iter< Int > )

    return that.reduce( ( sum, value ) -> sum + value );

  public static function average( that: Iter< Int > )

    return that.map( _ -> _ * 1.0 ).average();


  private static inline function compareInt( left: Int, right: Int )

    return left == right ? 0 : left > right ? 1 : -1;

  public static function maxKeyed< V >( that: EntryIter< Int, V >, last: Bool = false )

    return that.maxKeyedBy( compareInt, last );

  public static function minKeyed< V >( that: EntryIter< Int, V >, last: Bool = false )

    return that.maxKeyedBy( compareInt, last );

  public static function maxValued< K >( that: EntryIter< K, Int >, last: Bool = false )

    return that.maxValuedBy( compareInt, last );

  public static function minValued< K >( that: EntryIter< K, Int >, last: Bool = false )

    return that.minValuedBy( compareInt, last );

}


class IterFloatTools {

  public static function max( that: Iter< Float > )

    return that.reduce( ( max, value ) -> value > max ? value : max );

  public static function min( that: Iter< Float > )

    return that.reduce( ( min, value ) -> value < min ? value : min );

  public static function product( that: Iter< Float > )

    return that.reduce( ( product, value ) -> product * value );

  public static function sum( that: Iter< Float > )

    return that.reduce( ( sum, value ) -> sum + value );

  public static function average( that: Iter< Float > ) {

    var index = 1.0;

    return that.reduce( ( average, value ) -> {

      index++;

      return ( average * ( index - 1 ) + value ) / index;

    } );

  }


  private static inline function compareFloat( left: Float, right: Float )

    return left == right ? 0 : left > right ? 1 : -1;

  public static function maxKeyed< V >( that: EntryIter< Float, V >, last: Bool = false )

    return that.maxKeyedBy( compareFloat, last );

  public static function minKeyed< V >( that: EntryIter< Float, V >, last: Bool = false )

    return that.maxKeyedBy( compareFloat, last );

  public static function maxValued< K >( that: EntryIter< K, Float >, last: Bool = false )

    return that.maxValuedBy( compareFloat, last );

  public static function minValued< K >( that: EntryIter< K, Float >, last: Bool = false )

    return that.minValuedBy( compareFloat, last );

}


class IterStringTools {

  public static function join( that: Iter< String >, separator: String = '' ) {

    final iterator = that.iterator();

    if ( ! iterator.hasNext() ) return '';

    final buffer = new StringBuf();

    buffer.add( iterator.next() );

    while ( iterator.hasNext() ) {

      buffer.add( separator );

      buffer.add( iterator.next() );

    }

    return buffer.toString();

  }

}

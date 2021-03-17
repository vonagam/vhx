package vhx.ds;

import vhx.funcs.Mapper;


class MapTools {

  public static inline function getOrSet< K, V >( map: Map< K, V >, key: K, value: Mapper< K, V > ): V {

    if ( ! map.exists( key ) ) map[ key ] = value( key );

    return map[ key ];

  }

  public static inline function getOr< K, V >( map: Map< K, V >, key: K, value: Mapper< K, V > ): V

    return map.exists( key ) ? map[ key ] : value( key );


  public static inline function assign< K, V >( map: Map< K, V >, values: KeyValueIterable< K, V > )

    for ( key => value in values ) map[ key ] = value;

}

package vhx.macro;

import haxe.macro.Expr;

import vhx.macro.ExprTools;


class MetaTools {

  public static function filter( data: ToMetadata, predicate: MetaPredicate ) {

    return [ for ( enrty in data ) if ( predicate( enrty ) ) enrty ];

  }

  public static function collect( data: ToMetadata, predicate: MetaPredicate ) {

    return [ for ( enrty in data ) if ( predicate( enrty ) ) enrty.params ];

  }

  public static function has( data: ToMetadata, predicate: MetaPredicate ) {

    for ( enrty in data ) if ( predicate( enrty ) ) return true;

    return false;

  }

  public static function find( data: ToMetadata, predicate: MetaPredicate ) {

    for ( enrty in data ) if ( predicate( enrty ) ) return nil( enrty );

    return nil();

  }

  public static function get( data: ToMetadata, predicate: MetaPredicate ) {

    for ( enrty in data ) if ( predicate( enrty ) ) return enrty.params;

    return nil();

  }

  public static function push( data: ToMetadata, meta: ToMetadataEntry ) {

    data.push( meta );

  }

  public static function unshift( data: ToMetadata, meta: ToMetadataEntry ) {

    data.unshift( meta );

  }

  public static function set( data: ToMetadata, meta: ToMetadataEntry ) {

    for ( index in 0...data.length ) if ( data[ index ].name == meta.name ) { data[ index ] = meta; return; }

    data.push( meta );

  }

  public static function defaultTo( data: ToMetadata, meta: ToMetadataEntry ) {

    for ( entry in data ) if ( entry.name == meta.name ) return;

    data.push( meta );

  }

  public static function remove( data: ToMetadata, predicate: MetaPredicate ) {

    var index = data.length;

    while ( --index >= 0 ) if ( predicate( data[ index ] ) ) data.splice( index, 1 );

  }


  public static function filterMeta( subject: { ?meta: Metadata }, predicate: MetaPredicate ) {

    return subject.meta == null ? [] : filter( subject.meta, predicate );

  }

  public static function collectMeta( subject: { ?meta: Metadata }, predicate: MetaPredicate ) {

    return subject.meta == null ? [] : collect( subject.meta, predicate );

  }

  public static function hasMeta( subject: { ?meta: Metadata }, predicate: MetaPredicate ) {

    return subject.meta == null ? false : has( subject.meta, predicate );

  }

  public static function findMeta( subject: { ?meta: Metadata }, predicate: MetaPredicate ) {

    return subject.meta == null ? nil() : find( subject.meta, predicate );

  }

  public static function getMeta( subject: { ?meta: Metadata }, predicate: MetaPredicate ) {

    return subject.meta == null ? nil() : get( subject.meta, predicate );

  }

  public static function pushMeta( subject: { ?meta: Metadata }, meta: ToMetadataEntry ) {

    subject.meta == null ? subject.meta = [ meta ] : push( subject.meta, meta );

  }

  public static function unshiftMeta( subject: { ?meta: Metadata }, meta: ToMetadataEntry ) {

    subject.meta == null ? subject.meta = [ meta ] : unshift( subject.meta, meta );

  }

  public static function setMeta( subject: { ?meta: Metadata }, meta: ToMetadataEntry ) {

    subject.meta == null ? subject.meta = [ meta ] : set( subject.meta, meta );

  }

  public static function defaultMetaTo( subject: { ?meta: Metadata }, meta: ToMetadataEntry ) {

    subject.meta == null ? subject.meta = [ meta ] : defaultTo( subject.meta, meta );

  }

  public static function removeMeta( subject: { ?meta: Metadata }, predicate: MetaPredicate ) {

    subject.meta == null ? subject.meta = null : remove( subject.meta, predicate );

  }

}


@:forward @:callable

abstract MetaPredicate( ( entry: MetadataEntry ) -> Bool )

from ( entry: MetadataEntry ) -> Bool

to ( entry: MetadataEntry ) -> Bool {

  @:from public static inline function fromPredicate( predicate: ( entry: MetadataEntry ) -> Bool ): MetaPredicate

    return predicate;

  @:from public static inline function fromNamePredicate( predicate: ( name: String ) -> Bool ): MetaPredicate

    return ( entry ) -> predicate( entry.name );

  @:from public static inline function fromString( name: String ): MetaPredicate

    return ( entry ) -> entry.name == name;

  @:from public static inline function fromStrings( names: Array< String > ): MetaPredicate

    return ( entry ) -> names.indexOf( entry.name ) != -1;

  @:from public static inline function fromEReg( pattern: EReg ): MetaPredicate

    return ( entry ) -> pattern.match( entry.name );

}

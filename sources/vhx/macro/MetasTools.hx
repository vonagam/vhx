package vhx.macro;

import haxe.macro.Expr;

import vhx.macro.ExprTools.*;

using vhx.macro.MetaTools;


class MetasTools {

  public static function getNativeName( entity: { name: String, ?meta: Metadata } ) {

    final meta = entity.getMeta( ':native' );

    final native = meta.turn( _ -> geString( _[ 0 ] ), entity.name );

    return native;

  }

  public static function setHaxeName( entity: { name: String, ?meta: Metadata }, name: String ) {

    if ( entity.name == name ) return;

    entity.defaultMetaTo( mNative( entity.name ) );

    entity.name = name;

  }

  public static function getOverloads( field: Field ) {

    final overloads = new Array< Function >();

    switch ( field.kind ) {

      case FFun( fun ): overloads.push( { params: fun.params, args: fun.args, ret: fun.ret, expr: eBlock() } );

      case _: throw 'Cannot get overloads for non-method field "${ field.name }".';

    }

    for ( args in field.collectMeta( ':overload' ) ) {

      switch ( args ) {

        case [ { expr: EFunction( _, fun ) } ]: overloads.push( fun );

        case _: throw 'Cannot get overload from non-function :overload meta for field "${ field.name }".';

      }

    }

    return overloads;

  }

}

package vhx.macro;

import Reflect;

import vhx.macro.ExprTools;

using vhx.macro.MetaTools;


class Printer extends haxe.macro.Printer {

  public override function printField( field: ToField ) {

    final optional = field.hasMeta( ':optional' );

    if ( optional ) {

      field = Reflect.copy( field );

      field.meta = field.meta.map( _ -> _.copy() );

      field.removeMeta( ':optional' );

      field.name = '?' + field.name;

    }

    final print = super.printField( field );

    final result = ~/var ([a-zA-Z0-9]+)\(default, default\)/.replace( print, 'var $1' );

    return result;

  }

}

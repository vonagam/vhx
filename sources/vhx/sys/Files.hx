package vhx.sys;

import haxe.io.Path;

import sys.FileSystem;

import sys.io.File;


class Files {

  public static function collect( path: String, ?filter: ( name: String, isDirectory: Bool ) -> Bool, recursive: Bool = false ) {

    final files = new Map< String, String >();

    collectInto( files, '', Path.removeTrailingSlashes( path ), filter, recursive );

    return files;

  }


  static function collectInto( files: Map< String, String >, relative: String, absolute: String, ?filter: ( name: String, isDirectory: Bool ) -> Bool, recursive: Bool ) {

    final names = FileSystem.readDirectory( absolute );

    for ( name in names ) {

      final absolute = Path.addTrailingSlash( absolute ) + name;

      final relative = ( relative == '' ? '' : Path.addTrailingSlash( relative ) ) + name;

      final isDirectory = FileSystem.isDirectory( absolute );

      if ( isDirectory && ! recursive ) continue;

      if ( isFalse( filter, _ -> _( relative, isDirectory ) ) ) continue;

      if ( isDirectory ) {

        collectInto( files, relative, absolute, filter, recursive );

      } else {

        files[ relative ] = File.getContent( absolute );

      }

    }

  }

}

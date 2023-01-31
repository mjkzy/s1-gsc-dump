// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

sarray_spawn()
{
    var_0 = spawnstruct();
    var_0.array = [];
    return var_0;
}

sarray_set( var_0, var_1 )
{
    self.array[var_0] = var_1;
}

sarray_get( var_0 )
{
    return self.array[var_0];
}

sarray_copy( var_0 )
{
    if ( isarray( var_0 ) )
        self.array = var_0;
    else
        self.array = var_0.array;
}

sarray_push( var_0 )
{
    self.array[self.array.size] = var_0;
}

sarray_pop()
{
    var_0 = self.array[self.array.size - 1];
    self.array[self.array.size - 1] = undefined;
    return var_0;
}

sarray_clear()
{
    self.array = [];
}

sarray_length()
{
    return self.array.size;
}

sarray_create_func_obj( var_0 )
{
    var_1 = spawnstruct();
    var_1.func = var_0;
    return var_1;
}

sarray_sort_by_handler( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_0 sarray_length() - 1; var_2++ )
    {
        for ( var_3 = var_2 + 1; var_3 < var_0 sarray_length(); var_3++ )
        {
            if ( var_1 [[ var_1.func ]]( var_0 sarray_get( var_3 ), var_0 sarray_get( var_2 ) ) )
            {
                var_4 = var_0 sarray_get( var_3 );
                var_0 sarray_set( var_3, var_0 sarray_get( var_2 ) );
                var_0 sarray_set( var_2, var_4 );
            }
        }
    }
}

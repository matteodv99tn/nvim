local ls    = require("luasnip")
local s     = ls.snippet
local sn    = ls.snippet_node
local t     = ls.text_node
local i     = ls.insert_node
local f     = ls.function_node
local d     = ls.dynamic_node
local fmt   = require("luasnip.extras.fmt").fmt
local fmta  = require("luasnip.extras.fmt").fmta
local rep   = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
    s({
        trig = "rlaunch:bootstrap",
    }, fmta(
        [[
        from launch import LaunchDescription
        from launch.actions import (
            DeclareLaunchArgument,
            IncludeLaunchDescription,
            OpaqueFunction,
            )
        from launch_ros.actions import Node
        from ament_index_python.packages import (
            get_package_share_directory,
            get_package_prefix,
            )


        def launch_setup(context, *args, **kwargs):
            <>


        def generate_launch_description():
            declared_arguments = []

            return LaunchDescription(
                declared_arguments  + [OpaqueFunction(function=launch_setup)]
                )
        ]],
        {
            i(0, "pass"),
        }
    ), {
        condition = line_begin
    }),

    s({
        trig = "rlaunch:node",
    }, fmta(
        [[
        Node(
            package="<>",
            executable="<>",
            output="<>",
            parameters=[<>],
            )
        ]],
        {
            i(1, "package name"), i(2, "executable name"), i(3, "both"),
            i(0)
        }
    ), {
        condition = line_begin
    }),
}

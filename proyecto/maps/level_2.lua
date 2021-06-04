return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.6.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 40,
  height = 24,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 34,
  nextobjectid = 44,
  properties = {},
  tilesets = {
    {
      name = "Terreno",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 17,
      image = "../img/terrain.png",
      imagewidth = 544,
      imageheight = 160,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      wangsets = {},
      tilecount = 85,
      tiles = {}
    }
  },
  layers = {
    {
      type = "group",
      id = 31,
      name = "background",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      layers = {
        {
          type = "imagelayer",
          image = "../img/landscape.png",
          id = 33,
          name = "fondo",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = -182.67,
          parallaxx = 1,
          parallaxy = 1,
          properties = {}
        }
      }
    },
    {
      type = "group",
      id = 13,
      name = "basic",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["collidable"] = true
      },
      layers = {
        {
          type = "tilelayer",
          x = 0,
          y = 0,
          width = 40,
          height = 24,
          id = 16,
          name = "border",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {
            ["collidable"] = true
          },
          encoding = "lua",
          data = {
            7, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 8,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
            24, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 25
          }
        },
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 12,
          name = "floor_sensor",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {},
          objects = {
            {
              id = 17,
              name = "floor",
              type = "",
              shape = "rectangle",
              x = 31.625,
              y = 735.773,
              width = 1216.5,
              height = 8.22727,
              rotation = 0,
              visible = false,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            }
          }
        }
      }
    },
    {
      type = "group",
      id = 30,
      name = "tile_map",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["collidable"] = true
      },
      layers = {
        {
          type = "tilelayer",
          x = 0,
          y = 0,
          width = 40,
          height = 24,
          id = 28,
          name = "elements",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {},
          encoding = "lua",
          data = {
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            24, 2, 2, 61, 71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 69, 62, 2, 2, 25,
            7, 36, 36, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 35, 36, 36, 8,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 35, 36, 36, 36, 36, 36, 36, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 1, 2, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 2, 3, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 35, 36, 36, 36, 36, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 35, 36, 36, 36, 36, 37, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 35, 36, 36, 36, 36, 36, 36, 36, 36, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            24, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 25,
            19, 19, 19, 24, 3, 0, 0, 0, 0, 0, 0, 35, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 36, 37, 0, 0, 0, 0, 0, 0, 1, 25, 19, 19, 19,
            19, 19, 19, 19, 24, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 25, 19, 19, 19, 19,
            19, 19, 19, 19, 19, 24, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 25, 19, 19, 19, 19, 19,
            19, 19, 19, 19, 19, 19, 24, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 25, 19, 19, 19, 19, 19, 19,
            19, 19, 19, 19, 19, 19, 19, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 25, 19, 19, 19, 19, 19, 19, 19
          }
        }
      }
    },
    {
      type = "group",
      id = 29,
      name = "sensors",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["collidable"] = true
      },
      layers = {
        {
          type = "objectgroup",
          draworder = "topdown",
          id = 32,
          name = "platforms",
          visible = true,
          opacity = 1,
          offsetx = 0,
          offsety = 0,
          parallaxx = 1,
          parallaxy = 1,
          properties = {},
          objects = {
            {
              id = 25,
              name = "p2",
              type = "",
              shape = "rectangle",
              x = 928.909,
              y = 319.963,
              width = 190.545,
              height = 2.21875,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 26,
              name = "p1",
              type = "",
              shape = "rectangle",
              x = 160.364,
              y = 319.938,
              width = 191.273,
              height = 3.15341,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 27,
              name = "p0",
              type = "",
              shape = "rectangle",
              x = 513,
              y = 191.906,
              width = 254.063,
              height = 6.59375,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 29,
              name = "p3",
              type = "",
              shape = "rectangle",
              x = 352.395,
              y = 575.969,
              width = 575.074,
              height = 8.3125,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 30,
              name = "p14",
              type = "",
              shape = "rectangle",
              x = 32.25,
              y = 576,
              width = 95.6875,
              height = 3.875,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 31,
              name = "p13",
              type = "",
              shape = "rectangle",
              x = 127.188,
              y = 608,
              width = 32.75,
              height = 4.0625,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 32,
              name = "p12",
              type = "",
              shape = "rectangle",
              x = 159.25,
              y = 640.063,
              width = 32.625,
              height = 5.4375,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 33,
              name = "p11",
              type = "",
              shape = "rectangle",
              x = 192.063,
              y = 671.938,
              width = 32,
              height = 4.625,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 34,
              name = "p10",
              type = "",
              shape = "rectangle",
              x = 223.188,
              y = 703.938,
              width = 32.75,
              height = 3.875,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 35,
              name = "p9",
              type = "",
              shape = "rectangle",
              x = 256,
              y = 736,
              width = 774.625,
              height = 6.9375,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 36,
              name = "p8",
              type = "",
              shape = "rectangle",
              x = 1024.09,
              y = 703.938,
              width = 35.2813,
              height = 3.4375,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 37,
              name = "p7",
              type = "",
              shape = "rectangle",
              x = 1056.06,
              y = 671.951,
              width = 39.5625,
              height = 6.92361,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 38,
              name = "p6",
              type = "",
              shape = "rectangle",
              x = 1088.09,
              y = 640.043,
              width = 38.8696,
              height = 5,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 39,
              name = "p5",
              type = "",
              shape = "rectangle",
              x = 1120.04,
              y = 607.87,
              width = 36.6087,
              height = 5.26087,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 40,
              name = "p4",
              type = "",
              shape = "rectangle",
              x = 1152,
              y = 576,
              width = 102.813,
              height = 10.5,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 41,
              name = "p15",
              type = "",
              shape = "rectangle",
              x = 1120.25,
              y = 159.908,
              width = 131.75,
              height = 10.4674,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 42,
              name = "p16",
              type = "",
              shape = "rectangle",
              x = 31.4545,
              y = 159.964,
              width = 128.182,
              height = 15.8545,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            },
            {
              id = 43,
              name = "p17",
              type = "",
              shape = "rectangle",
              x = 480.477,
              y = 383.984,
              width = 318.906,
              height = 1.70313,
              rotation = 0,
              visible = true,
              properties = {
                ["group"] = 3,
                ["friction"] = 0.8
              }
            }
          }
        }
      }
    }
  }
}

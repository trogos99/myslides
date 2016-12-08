{
  "image": "",
  "state": {
    "pan": {
      "x": 0,
      "y": 0
    },
    "zoom": 1
  },
  "board": "icezum",
  "graph": {
    "blocks": [
      {
        "id": "493ac379-6f2a-4614-b4ff-c36e77860e9d",
        "type": "basic.input",
        "data": {
          "label": "clk",
          "pin": {
            "name": "CLK",
            "value": "21"
          }
        },
        "position": {
          "x": 56,
          "y": 72
        }
      },
      {
        "id": "68bfabf7-767e-4075-abb7-c8eaf6a7b55f",
        "type": "larby",
        "data": {},
        "position": {
          "x": 272,
          "y": 56
        }
      },
      {
        "id": "9cc3cbf3-20c8-47ea-abca-4ee926a5711d",
        "type": "basic.output",
        "data": {
          "label": "led",
          "pin": {
            "name": "LED0",
            "value": "95"
          }
        },
        "position": {
          "x": 608,
          "y": 40
        }
      },
      {
        "id": "693e5186-2b18-4831-a681-3b48476d5460",
        "type": "basic.output",
        "data": {
          "label": "D13",
          "pin": {
            "name": "D13",
            "value": "144"
          }
        },
        "position": {
          "x": 608,
          "y": 120
        }
      },
      {
        "id": "ab72021a-71af-47f1-96db-343e4aba0617",
        "type": "basic.output",
        "data": {
          "label": "D12",
          "pin": {
            "name": "D12",
            "value": "143"
          }
        },
        "position": {
          "x": 608,
          "y": 200
        }
      }
    ],
    "wires": [
      {
        "source": {
          "block": "493ac379-6f2a-4614-b4ff-c36e77860e9d",
          "port": "out"
        },
        "target": {
          "block": "68bfabf7-767e-4075-abb7-c8eaf6a7b55f",
          "port": "dc6ac638-fb49-4fef-b6d0-eaa7d101596f"
        }
      },
      {
        "source": {
          "block": "68bfabf7-767e-4075-abb7-c8eaf6a7b55f",
          "port": "1f9d369a-e450-4eb4-b99d-98cef5b20636"
        },
        "target": {
          "block": "9cc3cbf3-20c8-47ea-abca-4ee926a5711d",
          "port": "in"
        }
      },
      {
        "source": {
          "block": "68bfabf7-767e-4075-abb7-c8eaf6a7b55f",
          "port": "9a5c2fd6-51f2-497f-8ef6-1a85f65c0cc6"
        },
        "target": {
          "block": "693e5186-2b18-4831-a681-3b48476d5460",
          "port": "in"
        }
      },
      {
        "source": {
          "block": "68bfabf7-767e-4075-abb7-c8eaf6a7b55f",
          "port": "4e120ec3-55d3-41be-859c-c84fd9c5ba54"
        },
        "target": {
          "block": "ab72021a-71af-47f1-96db-343e4aba0617",
          "port": "in"
        },
        "vertices": [
          {
            "x": 544,
            "y": 184
          }
        ]
      }
    ]
  },
  "deps": {
    "larby": {
      "image": "",
      "state": {
        "pan": {
          "x": 1.9999999999999716,
          "y": 21.999999999999687
        },
        "zoom": 1
      },
      "graph": {
        "blocks": [
          {
            "id": "dc6ac638-fb49-4fef-b6d0-eaa7d101596f",
            "type": "basic.input",
            "data": {
              "label": "clk"
            },
            "position": {
              "x": 32,
              "y": 128
            }
          },
          {
            "id": "1f9d369a-e450-4eb4-b99d-98cef5b20636",
            "type": "basic.output",
            "data": {
              "label": "led"
            },
            "position": {
              "x": 760,
              "y": 32
            }
          },
          {
            "id": "9a5c2fd6-51f2-497f-8ef6-1a85f65c0cc6",
            "type": "basic.output",
            "data": {
              "label": "Servo1"
            },
            "position": {
              "x": 760,
              "y": 120
            }
          },
          {
            "id": "4e120ec3-55d3-41be-859c-c84fd9c5ba54",
            "type": "basic.output",
            "data": {
              "label": "Servo2"
            },
            "position": {
              "x": 760,
              "y": 208
            }
          },
          {
            "id": "42897766-a348-454d-8b39-e9b73831ae00",
            "type": "basic.code",
            "data": {
              "code": "// @include divider.vh\n// @include genrom.v\n// @include genrom2.v\n// @include dividerp1.v\n// @include ServoUnit.v\n\n\n`include \"divider.vh\"\n\nparameter WAIT_DELAY = `T_50ms + `T_10ms;\n\n//-- Fichero con la rom\nparameter ROMFILE0 = \"rom0.list\";\nparameter ROMFILE1 = \"rom1.list\";\n\n//-- Numero de bits de la direccione\nparameter AW = 5;\nparameter DW = 8;\n\n//-- Just for debugging\nassign led = s0;\n\nwire [7:0] pos0;\nwire [7:0] pos1;\n\n//-- Intantiate the servo unit\nServoUnit\n  SERVO0 (.clk(clk),\n          .pos({1'b0,pos0[7:1]} + 8'd64),\n          .servo(s0));\n\nServoUnit\n  SERVO1 (.clk(clk),\n          .pos({1'b0,pos1[7:1]} + 8'd64),\n          .servo(s1));\n\nwire tic;\n\ndividerp1  #(WAIT_DELAY)\n   TIMMER0  (.clk(clk),\n             .timer_ena(1'b1),\n             .clk_out(tic));\n\nreg [AW-1: 0] addr = 0;  //-- Bus de direcciones\nreg [DW-1: 0] data;  //-- Bus de datos\n\nalways @(posedge clk)\n  if (tic)\n    addr <= addr + 1;\n\ngenrom\n   #( .ROMFILE(ROMFILE0),  //-- Asignacion de parametros\n      .AW(AW),\n      .DW(DW))\n   ROM0 (                  //-- coneion de cables\n      .clk(clk),\n      .addr(addr),\n       .data(pos0)\n   );\n\n\n   genrom2\n      #( .ROMFILE(ROMFILE1),  //-- Asignacion de parametros\n         .AW(AW),\n         .DW(DW))\n      ROM1 (                  //-- coneion de cables\n         .clk(clk),\n         .addr(addr),\n          .data(pos1)\n      );\n",
              "ports": {
                "in": [
                  "clk"
                ],
                "out": [
                  "led",
                  "s0",
                  "s1"
                ]
              }
            },
            "position": {
              "x": 248,
              "y": 32
            }
          }
        ],
        "wires": [
          {
            "source": {
              "block": "42897766-a348-454d-8b39-e9b73831ae00",
              "port": "led"
            },
            "target": {
              "block": "1f9d369a-e450-4eb4-b99d-98cef5b20636",
              "port": "in"
            }
          },
          {
            "source": {
              "block": "42897766-a348-454d-8b39-e9b73831ae00",
              "port": "s0"
            },
            "target": {
              "block": "9a5c2fd6-51f2-497f-8ef6-1a85f65c0cc6",
              "port": "in"
            }
          },
          {
            "source": {
              "block": "42897766-a348-454d-8b39-e9b73831ae00",
              "port": "s1"
            },
            "target": {
              "block": "4e120ec3-55d3-41be-859c-c84fd9c5ba54",
              "port": "in"
            }
          },
          {
            "source": {
              "block": "dc6ac638-fb49-4fef-b6d0-eaa7d101596f",
              "port": "out"
            },
            "target": {
              "block": "42897766-a348-454d-8b39-e9b73831ae00",
              "port": "clk"
            }
          }
        ]
      },
      "deps": {}
    }
  }
}
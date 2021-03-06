module GameState.PlayingLevel.Animation.Animation exposing
    ( Action(..)
    , Model
    , init
    , updateTick
    )

import Actor.Actor as Actor exposing (Level)
import Actor.Common as Common
import Data.Coordinate as Coordinate
import Data.Position as Position exposing (Position)
import Dict
import List.Extra


type alias Model =
    { positions : List Position
    , entities : Actor.Entities
    , entityNames : List String
    }


type Action
    = Stay Model Level
    | Finished


init : List Position -> Actor.Entities -> List String -> Model
init positions entities entityNames =
    { positions = positions
    , entities = entities
    , entityNames = entityNames
    }


updateTick : Int -> Model -> Level -> Action
updateTick currentTick model level =
    case model.positions of
        [] ->
            Finished

        position :: otherPositions ->
            Stay
                { model | positions = otherPositions }
                (addActor
                    currentTick
                    model
                    (Position.addPosition position (Coordinate.asPosition level.config.pixelSize level.view.coordinate))
                    level
                )


addActor : Int -> Model -> Position -> Level -> Level
addActor currentTick model position level =
    getEntityName currentTick model.entityNames
        |> Maybe.andThen (\a -> Dict.get a model.entities)
        |> Maybe.map
            (\entity ->
                Common.addActor
                    (Dict.insert
                        "transform"
                        (Actor.TransformComponent { position = position })
                        entity
                    )
                    level
            )
        |> Maybe.withDefault level


getEntityName : Int -> List String -> Maybe String
getEntityName currentTick entityNames =
    List.Extra.getAt
        (modBy (List.length entityNames) currentTick)
        entityNames

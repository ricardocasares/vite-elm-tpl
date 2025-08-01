module MainSpec exposing (suite)

import Main exposing (viewBodyForTesting)
import Test exposing (Test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector


suite : Test
suite =
    Test.describe "Main"
        [ Test.test "Displays the current prompt" <|
            \_ ->
                viewBodyForTesting "something funny"
                    |> Query.fromHtml
                    |> Query.has [ Selector.text "something funny" ]
        ]

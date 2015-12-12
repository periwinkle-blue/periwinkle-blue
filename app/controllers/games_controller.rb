class GamesController < ApplicationController
	def index

	end

	def show
		@board = [
					[1, 0, 1, 0, 1, 0, 1, 0],
					[0, 1, 0, 1, 0, 1, 0, 1],
					[1, 0, 1, 0, 1, 0, 1, 0],
					[0, 1, 0, 1, 0, 1, 0, 1],
					[1, 0, 1, 0, 1, 0, 1, 0],
					[0, 1, 0, 1, 0, 1, 0, 1],
					[1, 0, 1, 0, 1, 0, 1, 0],
					[0, 1, 0, 1, 0, 1, 0, 1]
				]
	end
end

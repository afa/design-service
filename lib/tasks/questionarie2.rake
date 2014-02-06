# coding: utf-8
namespace :questionarie do
	desc "Add 2 ankete"
	task :init2 => :environment do
		questionnaire = Questionnaire.new(:name => "Дизайнеры", :specialization_id => 8, :is_numeric => true)

	  	questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
	  		:questionnaire_field_id => 1,
	  		:value => 'Фамилия',
	  		:position => 1,
	  		:location => 'left',
	  		:is_necessarily => false,
	  		:kind => 'last_name'
		  	)
		questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
		  		:questionnaire_field_id => 1,
		  		:value => 'Имя',
		  		:position => 2,
		  		:location => 'left',
		  		:is_necessarily => false,
		  		:kind => 'first_name'
		  	)
		questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
		  		:questionnaire_field_id => 1,
		  		:value => 'Отчество',
		  		:position => 3,
		  		:location => 'left',
		  		:is_necessarily => false,
		  		:kind => 'patronymic'
		  	)
		questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
		  		:questionnaire_field_id => 1,
		  		:value => 'E-mail',
		  		:position => 5,
		  		:location => 'left',
		  		:is_necessarily => false,
		  		:kind => 'email'
		  	)
		questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
		  		:questionnaire_field_id => 1,
		  		:value => 'Тел.моб.',
		  		:position => 6,
		  		:location => 'left',
		  		:is_necessarily => false,
		  		:kind => 'phone'
		  	)
		questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
		  		:questionnaire_field_id => 2,
		  		:value => 'Дата рождения',
		  		:position => 1,
		  		:location => 'right',
		  		:is_necessarily => false
		  	)
		questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
		  		:questionnaire_field_id => 3,
		  		:value => 'Проживание',
		  		:position => 2,
		  		:location => 'right',
		  		:is_necessarily => false
		  	)
		questionnaire.questionnaire_fields_questionnaires << QuestionnaireFieldsQuestionnaire.new(
		  		:questionnaire_field_id => 4,
		  		:value => 'Фотография',
		  		:position => 1,
		  		:location => 'center_full',
		  		:is_necessarily => false
		  	)

		question1 = Question.new(
			:position => 1,
			:name => 'Гармоничное решение стиля - классицизм',
			:count_true => 1,
			:count_all => 6,
			:kind => 'photo_test',
			:is_necessarily => false,
			:value => ''
		)
		question1.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 1,
				:statis_is_true => true,
				:status_is_false => false
			)
		question1.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 2,
				:statis_is_true => false,
				:status_is_false => true
			)
		question1.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 3,
				:statis_is_true => false,
				:status_is_false => false
			)
		question1.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 4,
				:statis_is_true => false,
				:status_is_false => false
			)
		question1.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 5,
				:statis_is_true => false,
				:status_is_false => false
			)
		question1.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 6,
				:statis_is_true => false,
				:status_is_false => false
			)

		questionnaire.questions << question1

		question2 = Question.new(
			:position => 2,
			:name => 'Гармоничное решение стиля - арт-деко',
			:count_true => 1,
			:count_all => 6,
			:kind => 'photo_test',
			:is_necessarily => false,
			:value => ''
		)
		question2.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 1,
				:statis_is_true => true,
				:status_is_false => false
			)
		question2.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 2,
				:statis_is_true => false,
				:status_is_false => true
			)
		question2.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 3,
				:statis_is_true => false,
				:status_is_false => false
			)
		question2.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 4,
				:statis_is_true => false,
				:status_is_false => false
			)
		question2.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 5,
				:statis_is_true => false,
				:status_is_false => false
			)
		question2.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 6,
				:statis_is_true => false,
				:status_is_false => false
			)

		questionnaire.questions << question2

		question3 = Question.new(
			:position => 3,
			:name => 'Гармоничное решение восточного стиля',
			:count_true => 1,
			:count_all => 6,
			:kind => 'photo_test',
			:is_necessarily => false,
			:value => ''
		)
		question3.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 1,
				:statis_is_true => true,
				:status_is_false => false
			)
		question3.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 2,
				:statis_is_true => false,
				:status_is_false => true
			)
		question3.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 3,
				:statis_is_true => false,
				:status_is_false => false
			)
		question3.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 4,
				:statis_is_true => false,
				:status_is_false => false
			)
		question3.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 5,
				:statis_is_true => false,
				:status_is_false => false
			)
		question3.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'photo_test',
				:position => 6,
				:statis_is_true => false,
				:status_is_false => false
			)

		questionnaire.questions << question3

		question4 = Question.new(
			:position => 1,
			:name => 'Ваши навыки',
			:count_true => 0,
			:count_all => 0,
			:kind => 'check_need',
			:is_necessarily => false,
			:value => ''
		)
		question4.question_fields << QuestionField.new(
				:name => 'Рисунок от руки',
				:value => '',
				:display => 'check_select',
				:position => 1,
				:statis_is_true => false,
				:status_is_false => false
			)
		question4.question_fields << QuestionField.new(
				:name => '3D визуализация',
				:value => '',
				:display => 'check_select',
				:position => 2,
				:statis_is_true => false,
				:status_is_false => false
			)
		questionnaire.questions << question4

		question5 = Question.new(
			:position => 2,
			:name => 'Перечень программ, в которых Вы работаете',
			:count_true => 0,
			:count_all => 0,
			:kind => 'check_need',
			:is_necessarily => false,
			:value => ''
		)
		question5.question_fields << QuestionField.new(
				:name => 'AutoCAD',
				:value => '',
				:display => 'check_select',
				:position => 1,
				:statis_is_true => false,
				:status_is_false => false
			)
		question5.question_fields << QuestionField.new(
				:name => 'Adobe Photoshop',
				:value => '',
				:display => 'check_select',
				:position => 2,
				:statis_is_true => false,
				:status_is_false => false
			)
		question5.question_fields << QuestionField.new(
				:name => 'ArchiCAD',
				:value => '',
				:display => 'check_select',
				:position => 3,
				:statis_is_true => false,
				:status_is_false => false
			)
		question5.question_fields << QuestionField.new(
				:name => 'Adobe Illustrator',
				:value => '',
				:display => 'check_select',
				:position => 4,
				:statis_is_true => false,
				:status_is_false => false
			)
		question5.question_fields << QuestionField.new(
				:name => '3D Max',
				:value => '',
				:display => 'check_select',
				:position => 5,
				:statis_is_true => false,
				:status_is_false => false
			)
		question5.question_fields << QuestionField.new(
				:name => 'Coral Draw',
				:value => '',
				:display => 'check_select',
				:position => 6,
				:statis_is_true => false,
				:status_is_false => false
			)
		question5.question_fields << QuestionField.new(
				:name => 'Другое',
				:value => '',
				:display => 'check_value',
				:position => 7,
				:statis_is_true => false,
				:status_is_false => false
			)
		questionnaire.questions << question5

		question7 = Question.new(
			:position => 4,
			:name => 'Техники, которыми Вы лучше всего владеете',
			:count_true => 0,
			:count_all => 0,
			:kind => 'check_need',
			:is_necessarily => false,
			:value => ''
		)
		question7.question_fields << QuestionField.new(
				:name => 'Ткани',
				:value => '',
				:display => 'check_select',
				:position => 1,
				:statis_is_true => false,
				:status_is_false => false
			)
		question7.question_fields << QuestionField.new(
				:name => 'Изделия из металла',
				:value => '',
				:display => 'check_select',
				:position => 2,
				:statis_is_true => false,
				:status_is_false => false
			)
		question7.question_fields << QuestionField.new(
				:name => 'Изделия из дерева и мебель',
				:value => '',
				:display => 'check_select',
				:position => 3,
				:statis_is_true => false,
				:status_is_false => false
			)
		question7.question_fields << QuestionField.new(
				:name => 'Камень и гипс',
				:value => '',
				:display => 'check_select',
				:position => 4,
				:statis_is_true => false,
				:status_is_false => false
			)
		question7.question_fields << QuestionField.new(
				:name => 'Витражи и мозаика. Изделия из стекла',
				:value => '',
				:display => 'check_select',
				:position => 5,
				:statis_is_true => false,
				:status_is_false => false
			)
		questionnaire.questions << question7

		question8 = Question.new(
			:position => 5,
			:name => 'Вопрос на кругозор',
			:count_true => 0,
			:count_all => 0,
			:kind => 'random_question',
			:is_necessarily => false,
			:value => ''
		)
		question8.question_fields << QuestionField.new(
				:name => 'Вопрос №1',
				:value => '',
				:display => 'question_for_random_question',
				:position => 1,
				:statis_is_true => false,
				:status_is_false => false
			)
		question8.question_fields << QuestionField.new(
				:name => 'Вопрос №2',
				:value => '',
				:display => 'question_for_random_question',
				:position => 2,
				:statis_is_true => false,
				:status_is_false => false
			)
		questionnaire.questions << question8

		question9 = Question.new(
			:position => 6,
			:name => 'Ваши достижения',
			:count_true => 0,
			:count_all => 0,
			:kind => 'add_files',
			:is_necessarily => false,
			:value => ''
		)
		question9.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'description_with_file',
				:position => 1,
				:statis_is_true => false,
				:status_is_false => false
			)
		question9.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'description_with_file',
				:position => 2,
				:statis_is_true => false,
				:status_is_false => false
			)
		question9.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'description_with_file',
				:position => 3,
				:statis_is_true => false,
				:status_is_false => false
			)
		questionnaire.questions << question9

		question10 = Question.new(
			:position => 7,
			:name => 'Ваш опыт работы в компаниях',
			:count_true => 0,
			:count_all => 0,
			:kind => 'experience_min',
			:is_necessarily => false,
			:value => ''
		)
		question10.question_fields << QuestionField.new(
				:name => '',
				:value => '',
				:display => 'experience_min',
				:position => 1,
				:statis_is_true => false,
				:status_is_false => false
			)
		questionnaire.questions << question10

		questionnaire.save
	end
end
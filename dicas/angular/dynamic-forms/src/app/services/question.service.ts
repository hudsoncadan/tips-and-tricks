import { Injectable } from '@angular/core';
import { of } from 'rxjs';
import { delay } from 'rxjs/internal/operators';

import { DropdownQuestion } from 'src/app/models/question-dropdown';
import { QuestionBase } from 'src/app/models/question-base';
import { TextboxQuestion } from 'src/app/models/question-textbox';

@Injectable()
export class QuestionService {

    // TODO: Selecionar perguntas de um back-end
    getQuestions() {

        const questions: QuestionBase<string>[] = [

            new DropdownQuestion({
                key: 'pets',
                label: 'Animal de Estimação',
                options: [
                    { key: 'cachorro', value: 'Cachorro' },
                    { key: 'gato', value: 'Gato' },
                    { key: 'cachorro-e-gato', value: 'Cachorro e Gato' },
                    { key: 'outros', value: 'Outros' }
                ],
                order: 3
            }),

            new TextboxQuestion({
                key: 'nome',
                label: 'Nome',
                required: true,
                order: 1
            }),

            new TextboxQuestion({
                key: 'email',
                label: 'E-mail',
                type: 'email',
                order: 2
            }),

            new TextboxQuestion({
                key: 'pais',
                label: 'País',
                type: 'text',
                value: 'Brasil',
                order: 4
            })
        ];

        // Simula o retorno de uma API com um delay de 2 segundos
        return of(questions.sort((a, b) => a.order - b.order))
            .pipe(
                delay(2000)
            );
    }
}
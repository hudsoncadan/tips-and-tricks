import { Injectable } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

// Models
import { QuestionBase } from 'src/app/models/question-base';

@Injectable()
export class QuestionControlService {
    constructor() { }

    toFormGroup(questions: QuestionBase<string>[]) {
        const group: any = {};

        questions?.forEach(question => {
            group[question.key] = question.required ? new FormControl(question.value || '', Validators.required)
                : new FormControl(question.value || '');
        });
        
        return new FormGroup(group);
    }
}
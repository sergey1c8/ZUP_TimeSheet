export interface ISubdivision  {
    readonly pk: string;
    readonly name: string;
    readonly code: string;
    readonly parent_pk: string;
    readonly organization_pk: string;
    readonly hasChild: boolean
}